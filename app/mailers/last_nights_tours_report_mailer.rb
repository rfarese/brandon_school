class LastNightsToursReportMailer < ApplicationMailer
  default from: "\"Brandon IT Department\" <no-reply@example.com>"

  def new_report
    attachments['last_nights_tours.csv'] = File.read("./tmp/last_nights_tours.csv")
    mail(
      to: "robertfarese@yahoo.com",
      subject: "Last Nights Tours Reports"
    )
  end
end
