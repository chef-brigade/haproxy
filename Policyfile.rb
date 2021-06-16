name 'haproxy'

default_source :supermarket, 'https://supermarket.chef.io'
cookbook 'haproxy', path: '.'
cookbook 'test', path: 'test/cookbooks/test'
run_list 'haproxy'

Dir.each_child('./test/cookbooks/test/recipes'). do |test|
  test = test.gsub('.rb', '')
  named_run_list test.to_sym, "test::#{test}"
end
