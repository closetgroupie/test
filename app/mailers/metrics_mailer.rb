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

  def daily_metrics_email
    set_count_variables
    mail(to: User.find(3).email, subject: "ClosetGroupie Daily Metrics")
  end

  def weekly_metrics_email
    set_count_variables
    mail(to: User.find(3).email, subject: "ClosetGroupie Weekly Metrics")
  end

  def monthly_metrics_email
    set_count_variables
    mail(to: User.find(3).email, subject: "ClosetGroupie Monthly Metrics")
  end
end
