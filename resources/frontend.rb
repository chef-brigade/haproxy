property :name, String, name_property: true
property :bind, String, default: '0.0.0.0:80'
property :maxconn, Integer, default: 2000
property :http_request, String
property :http_response, String
property :config_dir, String, default: '/etc/haproxy'
property :config_file, String, default: lazy { ::File.join(config_dir, 'haproxy.cfg') }
property :default_backend, String, required: true
property :use_backend, Array
property :acl, Array
property :option, Array
property :extra_options, Hash

action :create do
  # As we're using the accumulator pattern we need to shove everything
  # into the root run context so each of the sections can find the parent
  with_run_context :root do
    edit_resource(:template, config_file) do | new_resource |
      cookbook 'haproxy'
      variables['frontend'] ||= {}
      variables['frontend'][new_resource.name] ||= {}
      variables['frontend'][new_resource.name]['bind'] ||= ''
      variables['frontend'][new_resource.name]['bind'] << new_resource.bind
      variables['frontend'][new_resource.name]['maxconn'] ||= ''
      variables['frontend'][new_resource.name]['maxconn'] << new_resource.maxconn.to_s
      variables['frontend'][new_resource.name]['http_request'] ||= '' unless new_resource.http_request.nil?
      variables['frontend'][new_resource.name]['http_request'] << new_resource.http_request unless new_resource.http_request.nil?
      variables['frontend'][new_resource.name]['http_response'] ||= '' unless new_resource.http_response.nil?
      variables['frontend'][new_resource.name]['http_response'] << new_resource.http_response unless new_resource.http_response.nil?
      variables['frontend'][new_resource.name]['default_backend'] ||= ''
      variables['frontend'][new_resource.name]['default_backend'] << new_resource.default_backend
      variables['frontend'][new_resource.name]['use_backend'] ||= [] unless new_resource.use_backend.nil?
      variables['frontend'][new_resource.name]['use_backend'] << new_resource.use_backend unless new_resource.use_backend.nil?
      variables['frontend'][new_resource.name]['acl'] ||= [] unless new_resource.acl.nil?
      variables['frontend'][new_resource.name]['acl'] << new_resource.acl unless new_resource.acl.nil?
      variables['frontend'][new_resource.name]['option'] ||= [] unless new_resource.option.nil?
      variables['frontend'][new_resource.name]['option'] << new_resource.option unless new_resource.option.nil?
      variables['frontend'][new_resource.name]['extra_options'] ||= {} unless new_resource.extra_options.nil?
      variables['frontend'][new_resource.name]['extra_options'] = new_resource.extra_options unless new_resource.extra_options.nil?

      action :nothing
      delayed_action :create
    end
  end
end
