# haproxy Cookbook CHANGELOG

This file is used to list changes made in each version of the haproxy cookbook.

## Unreleased

## 12.2.0 - _2021-06-21_

- Add `use_promex` property to install.rb to support compiling with Prometheus Exporter support - [@Wicaeed](https://github.com/wicaeed)

#

## 12.1.0 - _2021-06-14_

- Add `ssl_lib` and `ssl_inc` properties to `haproxy_install` to support openssl - [@derekgroh](https://github.com/derekgroh)

## 12.0.1 - _2021-06-01_

## 12.0.0 - _2021-05-13_

- Refactor to use resource partials
- Add delete action to most resources
- Convert `install` resource boolean strings to true/false
- Ensure section is created before adding an ACL

## 11.0.0 - _2021-05-07_

- Drop testing for Debian 8, Ubuntu 16.04 & Ubuntu 18.04
- Add testing for Debian 9 Ubuntu 20.04 & Ubuntu 21.04
- Fix the minimum Chef version to 15.3
  unified_mode was introduced in 15.3
- Change kitchen to use the Bento provided Amazonlinux2 image
- Fix test suite

## 10.0.1 - _2021-04-26_

- Add missing configuration file properties to all resources

## 10.0.0 - _2021-04-24_

- Add configuration test function to the service resource - [@bmhughes](https://github.com/bmhughes)
- Fix generating multiple actions from the service resource - [@bmhughes](https://github.com/bmhughes)
- Kitchen test with CentOS 8/8 stream - [@bmhughes](https://github.com/bmhughes)
- Fix IUS repo causing a run failure on an unsupported platform - [@bmhughes](https://github.com/bmhughes)
- Move configuration resource creation into resource helper module - [@bmhughes](https://github.com/bmhughes)

## [v9.1.0] (2020-10-07)

### Added

- testing for haproxy 2.2

### Removed

- testing for haproxy 1.9 & 2.1

## [v9.0.1] (2020-09-15)

### Added

- added lua compilation flags to `haproxy_install` resource

### Fixed

- resolved cookstyle error: libraries/helpers.rb:19:24 refactor: `ChefCorrectness/InvalidPlatformFamilyInCase`
- Updated IUS repo url to `https://repo.ius.io/ius-release-el7.rpm`

### Changed

- Turn on unified_mode for all resources

## [v9.0.0] (2020-02-21)

### Changed

- Removed `depends_on` build-essential, as this is now in Chef Core

### Fixed

- Cookstyle fixes for cookstyle version 5.20

## [v8.3.0] (2020-01-09)

### Added

- on `haproxy_install` epel is now a configurable option

### Changed

- Migrated testing to github actions

### Fixed

- ius repo will only echo out if enabled

## [v8.2.0] (2019-12-23)

### Added

- `fastcgi` resource to support FastCGI applications

### Changed

- Default source install version is haproxy 2.1

### Fixed

- Bug with single newline between resources when multiple of the same type are defined

### Removed

- `.foodcritic` as it is no longer run by deliver local.
- `.rubocop.yml` as no longer required.

## [v8.1.1] (2019-10-02)

### Changed

- Updated `config_defaults` resourcce `stats` property default value to empty hash.
- Updated metadata.rb chef_version to >=13.9 due to resource `description`.

## [v8.1.0] (2019-06-24)

### Changed

- Updated build target to linux-glibc for haproxy 2.0 compatibility.
- Updated integration tests to cover haproxy 2.0.
- Moved install resource target_os check to libraries.

## [v8.0.0] (2019-05-29)

### Added

- The bind config hash joins with a space instead of a colon.
- The peer resource.
- The mailer resource.

## [v7.1.0] (2019-04-16)

### Changed

- Clean up unused templates and files.

### Fixed

- Name conflict with systemd_unit in service resource.

## [v7.0.0] (2019-04-10)

### Added

- `health` to allowed values for `mode` on `frontend`, `backend`, `listen`, `default`.
- `apt-update` for debian platforms.
- ius repo for CentOS and Redhat package installations (resolves #348).

### Changed

- Clean up unit and integration test content regular expressions.
- Move system command to a helper.
- Support only systemd init systems.

### Removed

- Remove `poise_service` dependency in favor of systemd_unit.

### Fixed

- Fix cookbook default value in `config_global`.

## [v6.4.0] (2019-03-20)

### Changed

- Move resource documentation to dedicated folder with md per resource.
- Rename haproxy_cache `name` property as `cache_name`.

### Fixed

- Source installs on CentOS 6.

## [v6.3.0] (2019-02-18)

### Added

- Haproxy_cache resource for caching small objects with HAProxy version >=1.8.

### Changed

- Expand integration test coverage to all stable and LTS HAProxy versions.
- Documentation - clarify extra_options hash string => array option.
- Clarify the supported platforms - add AmazonLinux 2, remove fedora & freebsd.

## [v6.2.7] (2019-01-10)

### Added

- Test for appropriate spacing from start of line and end of line.
- `hash_type` param to `haproxy_backend`, `haproxy_listen`, and `haproxy_config_defaults` resources.
- `reqirep` and `reqrep` params to `haproxy_backend`, `haproxy_frontend`, and `haproxy_listen` resources.
- `sensitive` param to `haproxy_install`; set to false to show diff output during Chef run.

### Changed

- Allow passing an array to `haproxy_listen`'s `http_request` param.

### Fixed

- Fix ordering for `haproxy_listen`: `acl` directives should be applied before `http-request`.

## [v6.2.6] (2018-11-05)

### Changed

- Put `http_request` rules before the `use_backend`.

## [v6.2.5] (2018-10-09)

### Added

- rspec examples for resource usage.

### Removed

- Chef-12 support.
- CPU cookbook dependency.

### Fixed

- Systemd wrapper, the wrapper is no longer included with haproxy versions greater than 1.8.

## [v6.2.4] (2018-09-19)

### Added

- Server property to listen resource and config template.

## [v6.2.3] (2018-08-03)

### Removed

- A few resource default values so they can be specified in the haproxy.cfg default section and added service reload exmample to the readme for config changes.

## [v6.2.2] (2018-08-03)

### Changed

- Made `haproxy_install` `source_url` property dynamic with `source_version` property and removed the need to specify checksum #307.

## [v6.2.1] (2018-08-01)

### Added

- Compiling from source crypt support #305.

## [v6.2.0] (2018-05-11)

### Changed

- Require Chef 12.20 or later.
- Uses the build_essential resource not the default recipe so the cookbook can be skipped entirely if running on Chef 14+.

## [v6.1.0] (2018-04-12)

### **Breaking changes**

### Added

- `haproxy_service` resource see test suites for usage.
- Support for haproxy 1.8.
- Test haproxy version 1.8.7 and 1.7.8.
- Test on chef-client version 13.87 and 14.
- Notes on how we generate the travis.yml list.

### Changed

- Require Chef 12.20 or later.
- Uses the build_essential resource not the default recipe so the cookbook can be skipped entirely if running on Chef 14+.
- Simplify the kitchen matrix.
- Use default action in tests (:create).
- Set the use_systemd property from the init package system.
- Adding in systemd for SUSE Linux.

### Removed

- `kitchen.dokken.yml` suites and inherit from kitchen.yml.
- Amazon tests until a new dokken image is produced that is reliable.

### Fixed

- Source comparison.

## [v6.0.0] (2018-03-28)

### Removed

- `compat_resource` cookbok dependency and push the required Chef version to 12.20

## [v5.0.4] (2018-03-28)

### Changed

- Make 1.8.4 the default installed version (#279)
- Use dokken docker images
- Update tests for haproxy service
- tcplog is now a valid input for the `haproxy_config_defaults` resource (#284)
- bin prefix is now reflected in the service config. (#288, #289)

## [v5.0.3] (2018-02-02)

### Fixed

- `foodcritic` warning for not defining `name_property`.

## [v5.0.2] (2017-11-29)

### Fixed

- Typo in listen section, makes previously unprintable expressions, printable in http-request, http-response and `default_backend`.

## [v5.0.1] (2017-08-10)

### Removed

- useless blank space in generated config file haproxy.cfg

## [v5.0.0] (2017-08-07)

### Added

- Option for install only #251.

### Changed

- Updating service to use cookbook template.
- updating to haproxy 1.7.8, updating `source_version` in test files(kitchen,cookbook, etc)
- updating properties to use `new_resource`

### Fixed

- `log` `property` in `global` resource can now be of type `Array` or `String`. This fixes #252
- fixing supports line #258

## [v4.6.1] (2017-08-02)

### Changed

- Reload instead of restart on config change
- Specify -sf argument last to support haproxy < 1.6.0

## [v4.6.0] (2017-07-13)

### Added

- `conf_template_source`
- `conf_cookbook`
- Support Array value for `extra_options` entries. (#245, #246)

## [v4.5.0] (2017-06-29)

### Added

- `resolver` resource (#240)

## [v4.4.0] (2017-06-28)

### Added

- `option` as an Array `property` for `backend` resource. This fixes #234
- Synced Debian/Ubuntu init script with latest upstream package changes

## [v4.3.1] (2017-06-13)

### Added

- Oracle Linux 6 support

### Removed

- Scientific linux support as we don't have a reliable image

## [v4.3.0] (2017-05-31)

### Added

- Chefspec Matchers for the resources defined in this cookbook.
- `mode` property to `backend` and `frontend` resources.
- `maxconn` to `global` resource.

### Removed

- `default_backend` as a required property on the `frontend` resource.

## [v4.2.0] (2017-05-04)

### Added

- In `acl` resource, usage: `test/fixtures/cookbooks/test/recipes/config_acl.rb`
- In `use_backend` resource, usage: `test/fixtures/cookbooks/test/recipes/config_acl.rb`
- `acl` and `use_backend` to `listen` resource.
- Amazon Linux as a supported platform.

### Changed

- Pinned `build-essential`, `>= 8.0.1`
- Pinned `poise-service`, `>= 1.5.1`
- Cleaned up arrays in `templates/default/haproxy.cfg.erb`

### Fixed

- Init script for Amazon Linux.

### BREAKING CHANGES

- This version removes `stats_socket`, `stats_uri` and `stats_timeout` properties from the `haproxy_global` and `haproxy_listen` resources in favour of using a hash to pass configuration options.

## [v4.1.0] (2017-05-01)

### Added

- `userlist` resource, to see usage: `test/fixtures/cookbooks/test/recipes/config_1_userlist.rb`
- chef-search example in: `test/fixtures/cookbooks/test/recipes/config_backend_search.rb`
- Multiple addresses and ports on listener and frontend (#205)

### Changed

- Updating source install test to take node attributes as haproxy.org is slow.

### Fixed

- `haproxy_retries` in `haproxy_config_defaults` resource

## [v4.0.2] (2017-04-21)

### Fixed

- haproxy service start on Ubuntu 14.04 (#199)
- Reload HAProxy when changing configuration (#197)

## [v4.0.1] (2017-04-20)

### Added

- Updating README.md
- Adding compat_resource for chef-12 support
- Improvement when rendering the configuration file (#196)

## [v4.0.0] (2017-04-18)

### COMPATIBILIY WARNING

- This version removes the existing recipes, attributes, and instance provider in favor of the new haproxy*install and haproxy* configuration resources. Why not just leave them in place? Well unfortunately they were utterly broken for anything other than the most trivial usage. Rather than continue the user pain we've opted to remove them and point users to a more modern installation method. If you need the legacy installation methods simply pin to the 3.0.4 release.
- THIS IS GOING TO BREAK EVERYTHING YOU KNOW AND LOVE
- 12.5 or greater rewrite
- Custom Resource Only, no recipes

## [v3.0.4] (2017-03-29)

### Fixed

- Bug introduced in (#174) (#182)

## [v3.0.3] (2017-03-28)

### Added

- Multiple addresses and ports on listener and frontend (#174)
- Customize logging destination (#178)

### Changed

- Updating to use bats/serverspec (#179)

## [v3.0.2] (2017-03-27)

### Added

- Allow server startup from `app_lb` recipe. (#171)
- Use Delivery instead of Rake
- Make this cookbook compatible with Chef-13, note: `params` option is now `parameters` (#175)

## [v3.0.1] (2017-01-30)

### Added

- Reload haproxy configuration on changes (#152)
- Merging in generic socket conf (#107)
- Updating config to use facilities hash dynamically (#102)
- Adding `tproxy` and splice per (#98)

### Removed

- Members with nil ips from member array. (#79)

## [v3.0.0] (2017-01-24)

### Added

- Configurable debug options
- CentOS7 compatibility (#123)
- Adding poise-service for service management

### Changed

- Updating source install to use Haproxy 1.7.2
- Chef >= 12.1 required
- Use `['haproxy']['source']['target_cpu']` instead of `['haproxy']['source']['target_os']` to detect correct architecture. (#150)

## [v2.0.2] (2016-12-30)

### Fixed

- Cookstyle
- The github URL for the repo in various locations

### Changed

- Travis testing updates
- Converted file modes to strings
- Updated the config resource to lazily evaluate node attribute values to better load the values when overridden in wrapper cookbooks

## v2.0.1 (2016-12-08)

### Fixed

- Dynamic configuration to properly template out frontend and backend sections

### Chnaged

- Update Chef Brigade to Sous Chefs
- Updated contributing docs to remove the reference to the develop branch

## v2.0.0 (2016-11-09)

### Breaking Changes

- The default recipe is now an empty recipe with manual configuration performed in the 'manual' recipe
- Remove Chef 10 compatibility code
- Switch from Librarian to Berksfile
- Updated the source recipe to install 1.6.9 by default

### Added

- Migrated this cookbook from Heavy Water to Chef Brigade so we can ensure more frequent releases and maintenance
- A code of conduct for the project. Read it.
- Several new syslog configuration attributes
- A new attribute for stats_socket_level
- A new attribute for retries
- A chefignore file to speed up syncs from the server
- Scientific and oracle as supported platforms in the metadata
- source_url, issues_url, and chef_version metadata
- Enabled why-run support in the default haproxy resource
- New haproxy_config resource
- Guardfile
- Testing in Travis CI with a Rakefile that runs cookstyle, foodcritic, and ChefSpec as well as a Kitchen Dokken config that does integration testing of the package install
- New node['haproxy']['pool_members'] and node['haproxy']['pool_members_option'] attributes

### Changed

- The haproxy config is now verified before the service restarts / reloads to prevent taking down haproxy with a bad config
- Update the Kitchen config file to use Bento boxes and new platforms
- Update ChefSpec matchers to use the latest format
- Broke search logic out into a new_discovery recipe

### Removed

- Attributes from the metadata file as these are redundant
- Broken tarball validation in the source recipe to prevented installs from completing

### Fixed

- Source installs not running if an older version was present on the node
- Resolved all cookstyle and foodcritic warnings

## v1.6.7

### Added

- ChefSpec matchers and test coverage

### Changed

- Replaced references to Opscode with Chef

## v1.6.6

### Changed

- Parameterize options for admin listener.
- Renamed templates/rhel to templates/redhat.
- Sort pool members by hostname to avoid needless restarts.
- Support amazon linux init script.
- Support to configure global options.

### Fixed

- CPU Tuning, corrects cpu_affinity resource triggers

## v1.6.4

## v1.6.2

### Added

- [COOK-3135](https://tickets.chef.io/browse/COOK-3135) - Allow setting of members with default recipe without changing the template.

### Fixed

- [COOK-3424](https://tickets.chef.io/browse/COOK-3424) - Haproxy cookbook attempts to alter an immutable attribute.

## v1.6.0

### Added

- Allow setting of members with default recipe without changing the template.

## v1.5.0

### Added

- [COOK-3660](https://tickets.chef.io/browse/COOK-3660) - Make haproxy socket default user group configurable
- [COOK-3537](https://tickets.chef.io/browse/COOK-3537) - Add OpenSSL and zlib source configurations
- [COOK-2384](https://tickets.chef.io/browse/COOK-2384) - Add LWRP for multiple haproxy sites/configs

## v1.4.0

### Added

- [COOK-3237](https://tickets.chef.io/browse/COOK-3237) - Enable cookie-based persistence in a backend
- [COOK-3216](https://tickets.chef.io/browse/COOK-3216) - Metadata attributes
- [COOK-3211](https://tickets.chef.io/browse/COOK-3211) - Support RHEL
- [COOK-3133](https://tickets.chef.io/browse/COOK-3133) - Allow configuration of a global stats socket

## v1.3.2

### Fixed

- [COOK-3046]: haproxy default recipe broken by COOK-2656.

### Added

- [COOK-2009]: Test-kitchen support to haproxy.

## v1.3.0

### Changed

- [COOK-2656]: Unify the haproxy.cfg with that from `app_lb`.

### Added

- [COOK-1488]: Provide an option to build haproxy from source.

## v1.2.0

### Added

- [COOK-1936] - use frontend / backend logic.
- [COOK-1937] - cleanup for configurations.
- [COOK-1938] - more flexibility for options.
- [COOK-1939] - reloading haproxy is better than restarting.
- [COOK-1940] - haproxy stats listen on 0.0.0.0 by default.
- [COOK-1944] - improve haproxy performance.

## v1.1.4

### Added

- [COOK-1839] - `httpchk` configuration to `app_lb` template.

## v1.1.0

### Changed

- [COOK-1275] - haproxy-default.erb should be a cookbook_file.

### Fixed

- [COOK-1594] - Template-Service ordering issue in `app_lb` recipe.

## v1.0.6

### Changed

- [COOK-1310] - Redispatch flag has changed.

## v1.0.4

### Changed

- [COOK-806] - Load balancer should include an SSL option.
- [COOK-805] - Fundamental haproxy load balancer options should be configurable.

## v1.0.3

### Changed

- [COOK-620] `haproxy::app_lb`'s template should use the member cloud private IP by default.

## v1.0.2

### Fixed

- Regression introduced in v1.0.1.

## v1.0.1

### Added

- Account for the case where load balancer is in the pool.

## v1.0.0

### Changed

- Use `node.chef_environment` instead of `node['app_environment']`.

[10.0.0 - *2021-04-24*]: https://github.com/sous-chefs/haproxy/compare/v6.4.0...HEAD
[v3.0.0]: https://github.com/sous-chefs/haproxy/compare/v2.0.2...v3.0.0
[v3.0.1]: https://github.com/sous-chefs/haproxy/compare/v3.0.0...v3.0.1
[v3.0.2]: https://github.com/sous-chefs/haproxy/compare/v3.0.1...v3.0.2
[v3.0.3]: https://github.com/sous-chefs/haproxy/compare/v3.0.2...v3.0.3
[v3.0.4]: https://github.com/sous-chefs/haproxy/compare/v3.0.3...v3.0.4
[v4.0.0]: https://github.com/sous-chefs/haproxy/compare/v3.0.4...v4.0.0
[v4.0.1]: https://github.com/sous-chefs/haproxy/compare/v4.0.0...v4.0.1
[v4.0.2]: https://github.com/sous-chefs/haproxy/compare/v4.0.1...v4.0.2
[v4.1.0]: https://github.com/sous-chefs/haproxy/compare/v4.0.2...v4.1.0
[v4.2.0]: https://github.com/sous-chefs/haproxy/compare/v4.1.0...v4.2.0
[v4.3.0]: https://github.com/sous-chefs/haproxy/compare/v4.2.0...v4.3.0
[v4.3.1]: https://github.com/sous-chefs/haproxy/compare/v4.3.0...v4.3.1
[v4.4.0]: https://github.com/sous-chefs/haproxy/compare/v4.3.1...v4.4.0
[v4.5.0]: https://github.com/sous-chefs/haproxy/compare/v4.4.0...v4.5.0
[v4.6.0]: https://github.com/sous-chefs/haproxy/compare/v4.5.0...v4.6.0
[v4.6.1]: https://github.com/sous-chefs/haproxy/compare/v4.6.0...v4.6.1
[v5.0.0]: https://github.com/sous-chefs/haproxy/compare/v4.6.1...v5.0.0
[v5.0.1]: https://github.com/sous-chefs/haproxy/compare/v5.0.0...v5.0.1
[v5.0.2]: https://github.com/sous-chefs/haproxy/compare/v5.0.1...v5.0.2
[v5.0.3]: https://github.com/sous-chefs/haproxy/compare/v5.0.2...v5.0.3
[v5.0.4]: https://github.com/sous-chefs/haproxy/compare/v5.0.3...v5.0.4
[v6.0.0]: https://github.com/sous-chefs/haproxy/compare/v5.0.4...v6.0.0
[v6.1.0]: https://github.com/sous-chefs/haproxy/compare/v6.0.0...v6.1.0
[v6.2.0]: https://github.com/sous-chefs/haproxy/compare/v6.1.0...v6.2.0
[v6.2.1]: https://github.com/sous-chefs/haproxy/compare/v6.2.0...v6.2.1
[v6.2.2]: https://github.com/sous-chefs/haproxy/compare/v6.2.1...v6.2.2
[v6.2.3]: https://github.com/sous-chefs/haproxy/compare/v6.2.2...v6.2.3
[v6.2.4]: https://github.com/sous-chefs/haproxy/compare/v6.2.3...v6.2.4
[v6.2.5]: https://github.com/sous-chefs/haproxy/compare/v6.2.4...v6.2.5
[v6.2.6]: https://github.com/sous-chefs/haproxy/compare/v6.2.5...v6.2.6
[v6.2.7]: https://github.com/sous-chefs/haproxy/compare/v6.2.6...v6.2.7
[v6.3.0]: https://github.com/sous-chefs/haproxy/compare/v6.2.7...v6.3.0
[v6.4.0]: https://github.com/sous-chefs/haproxy/compare/v6.3.0...v6.4.0
[v7.0.0]: https://github.com/sous-chefs/haproxy/compare/v6.4.0...v7.0.0
[v7.1.0]: https://github.com/sous-chefs/haproxy/compare/v7.0.0...v7.1.0
[v8.0.0]: https://github.com/sous-chefs/haproxy/compare/v7.1.0...v8.0.0
[v8.1.0]: https://github.com/sous-chefs/haproxy/compare/v8.0.0...v8.1.0
[v8.1.1]: https://github.com/sous-chefs/haproxy/compare/v8.1.0...v8.1.1
[v8.2.0]: https://github.com/sous-chefs/haproxy/compare/v8.1.1...v8.2.0
[v8.3.0]: https://github.com/sous-chefs/haproxy/compare/v8.2.0...v8.3.0
