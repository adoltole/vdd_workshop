package "libsqlite3-dev" do
  action :install
end

# start needed until upstream issue resolved: https://github.com/sj26/mailcatcher/issues/277 -- part 1 of 2
gem_package "mime-types" do
  version '< 3'
  action :install
end
# end needed until upstream issue resolved part 1 of 2

gem_package "mailcatcher" do
# start needed until upstream issue resolved part 2 of 2 
  options '--conservative'
  ignore_failure true
# end needed until upstream issue resolved part 2 of 2
   action :install
end

service "mailcatcher" do
  supports :restart => true, :start => true, :stop => true
  action :nothing
end

template "/etc/init.d/mailcatcher" do
  source "mailcatcher.upstart.erb"
  owner "root"
  group "root"
  mode "0755"
  notifies :enable, "service[mailcatcher]"
  notifies :restart, "service[mailcatcher]", :delayed
end
