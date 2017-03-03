class NotificationMailer < ApplicationMailer
  def new_notification(house_name)
    @house_name = house_name

    mail(
      to: "robertfarese@yahoo.com",
      subject: "No New Tours for #{house_name}"
    )
  end
end
