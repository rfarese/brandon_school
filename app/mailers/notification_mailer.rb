class NotificationMailer < ApplicationMailer
  default from: "\"Brandon School IT\" <no-reply@example.com>"

  def new_notification(house_name)
    @house_name = house_name

    mail(
      to: ["robertfarese@yahoo.com", "onappalertsext@brandonschool.org"],
      subject: "No New Tours for #{house_name}"
    )
  end
end
