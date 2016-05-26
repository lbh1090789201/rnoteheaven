set :output, "log/cron_log.log"

#全量备份应用数据， 每周四00:30
every :thursday, :at => '00:30' do
  rake "db:backup_config_data"
end

#全量备份业务数据， 每天23:30
every 1.day, :at => '23:30' do
  rake "db:backup_app_data"
end