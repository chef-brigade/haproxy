require 'spec_helper'

describe 'haproxy_' do
  step_into :haproxy_frontend, :haproxy_install, :haproxy_backend
  platform 'ubuntu'

  context 'create frontend and backend with http-request rule placed after use_backend' do
    recipe do
      haproxy_install 'package'

      haproxy_frontend 'admin' do
        bind '0.0.0.0:1337'
        mode 'http'
        use_backend ['admin0 if path_beg /admin0']
        extra_options('http-request' => 'add-header Test Value')
      end

      haproxy_backend 'admin' do
        server ['admin0 10.0.0.10:80 check weight 1 maxconn 100']
      end
    end

    it { is_expected.to render_file('/etc/haproxy/haproxy.cfg').with_content(/frontend admin/) }
    it { is_expected.to render_file('/etc/haproxy/haproxy.cfg').with_content(/http-request add-header Test Value.*use_backend admin0 if path_beg \/admin0/m) }
    it { is_expected.not_to render_file('/etc/haproxy/haproxy.cfg').with_content(/use_backend admin0 if path_beg \/admin0.*http-request add-header Test Value/m) }

  end
end
