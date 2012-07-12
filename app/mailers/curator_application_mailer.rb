class CuratorApplicationMailer < ActionMailer::Base
  default from: "ClosetGroupie.com <no-reply@closetgroupie.com>"
  layout "email"

  def new_curator_signup(application_id)
    @application = CuratorApplication.find(application_id)
    mail(to: "kelly@closetgroupie.com",
         subject: "New curator signup received! [closetgroupie]")
  end
end
