set :output, "/log/metrics_cron_log.log"
# TODO capistrano integration

every 1.day, :at => '3am' do
  runner "MetricsMailer.daily_metrics_email.deliver"
end

every :monday, :at => '3am' do
  runner "MetricsMailer.weekly_metrics_email.deliver"
end

every '0 3 1 * *' do # every first of the month at 3am
  runner "MetricsMailer.daily_metrics_email.deliver"
end
