class GroupMailer < ApplicationMailer
  def send_notification(group_users, title, content)
    @title = title
    @content = content
    @group_users = group_users
    mail(
      bcc: @group_users.pluck(:email),
      subject: @title
    )
  end
end
