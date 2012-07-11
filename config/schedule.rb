set :output, "/path/to/my/cron_log.log"
# TODO capistrano integration

every 1.day do
  runner "MyModel.some_method"
end

every 4.days do
  runner "AnotherModel.prune_old_records"
end
