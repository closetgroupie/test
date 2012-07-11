# TODO capistrano integration
#uncomment to use in development
#job_type :runner,  "cd :path && script/rails runner -e development ':task' :output"

set :output, "/var/log/metrics_cron.log"

every 1.day, :at => '3am' do
  runner "MetricsMailer.daily_metrics_email('kelly@closetgroupie.com').deliver"
  runner "MetricsMailer.daily_metrics_email('tres@closetgroupie.com').deliver"
  runner "MetricsMailer.daily_metrics_email('joonas@closetgroupie.com').deliver"
end

every :monday, :at => '3am' do
  runner "MetricsMailer.weekly_metrics_email('kelly@closetgroupie.com').deliver"
  runner "MetricsMailer.weekly_metrics_email('tres@closetgroupie.com').deliver"
  runner "MetricsMailer.weekly_metrics_email('joonas@closetgroupie.com').deliver"
end

every '0 3 1 * *' do # every first of the month at 3am
  runner "MetricsMailer.monthly_metrics_email('kelly@closetgroupie.com').deliver"
  runner "MetricsMailer.monthly_metrics_email('tres@closetgroupie.com').deliver"
  runner "MetricsMailer.monthly_metrics_email('joonas@closetgroupie.com').deliver"
end
