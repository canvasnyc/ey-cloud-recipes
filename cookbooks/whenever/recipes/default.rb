#
# Cookbook Name:: whenever
# Recipe:: default
#

ey_cloud_report "whenever" do
  message "starting whenever recipe"
end

if ['solo', 'util'].include?(node[:instance_role])

  node[:applications].each do |app_name, data|

    local_user = node[:users].first
    execute "whenever" do
      cwd "/data/#{app_name}/current"
      user local_user[:username]
      command "whenever --update-crontab '#{app_name}_#{node[:environment][:framework_env]}'"
      action :run
    end

    ey_cloud_report "whenever" do
      message "whenever recipe complete"
    end

  end

end
