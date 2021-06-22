include Haproxy::Cookbook::Helpers

use 'partial/_config_file'

property :install_type, String,
          name_property: true,
          equal_to: %w(package source),
          description: 'Set the installation type'

property :bin_prefix, String,
          default: '/usr',
          description: 'Set the source compile prefix'

property :sensitive, [true, false],
          default: true,
          description: 'Ensure that sensitive resource data is not logged by the chef-client'

# Package
property :package_name, String,
          default: 'haproxy'

property :package_version, [String, nil]

property :enable_ius_repo, [true, false],
          default: false,
          description: 'Enables the IUS package repo for Centos to install versions >1.5'

property :enable_epel_repo, [true, false],
          default: true,
          description: 'Enables the epel repo for RHEL based operating systems'

# Source
property :source_version, String,
          default: '2.2.4'

property :source_url, String,
          default: lazy { "https://www.haproxy.org/download/#{source_version.to_f}/src/haproxy-#{source_version}.tar.gz" }

property :source_checksum, String,
          default: '87a4d9d4ff8dc3094cb61bbed4a8eed2c40b5ac47b9604daebaf036d7b541be2'

property :source_target_cpu, String,
          default: lazy { node['kernel']['machine'] }

property :source_target_arch, String

property :source_target_os, String,
          default: lazy { target_os(source_version) }

property :use_libcrypt, [true, false],
          default: true

property :use_pcre, [true, false],
          default: true

property :use_promex, [true, false],
          default: false

property :use_openssl, [true, false],
          default: true

property :use_zlib, [true, false],
          default: true

property :use_linux_tproxy, [true, false],
          default: true

property :use_linux_splice, [true, false],
          default: true

property :use_lua, [true, false],
          default: false

property :lua_lib, String

property :lua_inc, String

property :ssl_lib, String

property :ssl_inc, String

property :use_systemd, [true, false],
          default: lazy { source_version.to_f >= 1.8 },
          description: 'Evalues whether to use systemd based on the nodes init package'

unified_mode true

action_class do
  include Haproxy::Cookbook::ResourceHelpers
end

action_class do
  include Haproxy::Cookbook::Helpers
  include Haproxy::Cookbook::ResourceHelpers

  def compile_make_boolean(bool)
    bool ? '1' : '0'
  end
end

action :install do
  case new_resource.install_type
  when 'package'
    case node['platform_family']
    when 'amazon'
      include_recipe 'yum-epel' if new_resource.enable_epel_repo
    when 'rhel'
      include_recipe 'yum-epel' if new_resource.enable_epel_repo

      if new_resource.enable_ius_repo
        if ius_platform_valid?
          puts ius_package[:url]

          remote_file ::File.join(Chef::Config[:file_cache_path], ius_package[:name]) do
            source ius_package[:url]
            only_if { new_resource.enable_ius_repo }
          end

          package ius_package[:name] do
            source ::File.join(Chef::Config[:file_cache_path], ius_package[:name])
            only_if { new_resource.enable_ius_repo }
          end
        else
          log 'This platform is not supported by IUS, ignoring enable_ius_repo property' do
            level :warn
          end
        end
      end
    end

    package new_resource.package_name do
      version new_resource.package_version if new_resource.package_version
    end
  when 'source'
    build_essential 'compilation tools'
    package source_package_list

    remote_file 'haproxy source file' do
      path ::File.join(Chef::Config[:file_cache_path], "haproxy-#{new_resource.source_version}.tar.gz")
      source new_resource.source_url
      checksum new_resource.source_checksum if new_resource.source_checksum
      action :create
    end

    make_cmd = "make TARGET=#{new_resource.source_target_os}"
    make_cmd << " CPU=#{new_resource.source_target_cpu}" if property_is_set?(:source_target_cpu)
    make_cmd << " ARCH=#{new_resource.source_target_arch}" if property_is_set?(:source_target_arch)
    make_cmd << " USE_LIBCRYPT=#{compile_make_boolean(new_resource.use_libcrypt)}"
    make_cmd << " USE_PCRE=#{compile_make_boolean(new_resource.use_pcre)}"
    make_cmd << " USE_OPENSSL=#{compile_make_boolean(new_resource.use_openssl)}"
    make_cmd << " USE_ZLIB=#{compile_make_boolean(new_resource.use_zlib)}"
    make_cmd << " USE_LINUX_TPROXY=#{compile_make_boolean(new_resource.use_linux_tproxy)}"
    make_cmd << " USE_LINUX_SPLICE=#{compile_make_boolean(new_resource.use_linux_splice)}"
    make_cmd << " USE_SYSTEMD=#{compile_make_boolean(new_resource.use_systemd)}"
    make_cmd << " USE_LUA=#{compile_make_boolean(new_resource.use_lua)}" if new_resource.use_lua
    make_cmd << " USE_PROMEX=#{compile_make_boolean(new_resource.use_promex)}" if new_resource.use_promex
    make_cmd << " LUA_LIB=#{new_resource.lua_lib}" if property_is_set?(:lua_lib)
    make_cmd << " LUA_INC=#{new_resource.lua_inc}" if property_is_set?(:lua_inc)
    make_cmd << " SSL_LIB=#{new_resource.ssl_lib}" if property_is_set?(:ssl_lib)
    make_cmd << " SSL_INC=#{new_resource.ssl_inc}" if property_is_set?(:ssl_inc)
    extra_cmd = ' EXTRA=haproxy-systemd-wrapper' if new_resource.source_version.to_f < 1.8

    bash 'compile_haproxy' do
      cwd Chef::Config[:file_cache_path]
      code <<-EOH
        tar xzf haproxy-#{new_resource.source_version}.tar.gz
        cd haproxy-#{new_resource.source_version}
        #{make_cmd} && make install PREFIX=#{new_resource.bin_prefix} #{extra_cmd}
      EOH
      not_if "#{::File.join(new_resource.bin_prefix, 'sbin', 'haproxy')} -v | grep #{new_resource.source_version}"
    end
  end

  with_run_context :root do
    group new_resource.group

    user new_resource.user do
      home "/home/#{new_resource.user}"
      group new_resource.group
    end
  end
end
