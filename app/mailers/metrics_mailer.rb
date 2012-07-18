class MetricsMailer < ActionMailer::Base
  include MetricsMailerHelper
  default from: "ClosetGroupie Metrics <no-reply@closetgroupie.com>"
  layout "email"

  class Curator < User
    default_scope :conditions => ['is_curator = true']
  end

  def set_count_variables
    @user_count = Count.new(User)
    @curator_count = Count.new(Curator)
    @order_count = Count.new(Order)
    @item_count = Count.new(Item)
  end

  def daily_metrics_email(email_address)
    set_count_variables
    headers["X-SMTPAPI"] = '{"category": "metrics:daily"}'
    mail(to: email_address, subject: "ClosetGroupie Daily Metrics")
  end

  def weekly_metrics_email(email_address)
    set_count_variables
    headers["X-SMTPAPI"] = '{"category": "metrics:weekly"}'
    mail(to: email_address, subject: "ClosetGroupie Weekly Metrics")
  end

  def monthly_metrics_email(email_address)
    set_count_variables
    headers["X-SMTPAPI"] = '{"category": "metrics:monthly"}'
    mail(to: email_address, subject: "ClosetGroupie Monthly Metrics")
  end
end
