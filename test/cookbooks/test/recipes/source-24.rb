apt_update

haproxy_install 'source' do
  source_url 'http://www.haproxy.org/download/2.4/src/haproxy-2.4.0.tar.gz'
  source_checksum '0a6962adaf5a1291db87e3eb4ddf906a72fed535dbd2255b164b7d8394a53640'
  source_version '2.4.0'
  use_libcrypt true
  use_pcre true
  use_openssl true
  use_zlib true
  use_promex true
  use_linux_tproxy true
  use_linux_splice true
end

haproxy_config_global ''

haproxy_config_defaults ''

haproxy_service 'haproxy' do
  action :create
  delayed_action %i(enable start)
end
