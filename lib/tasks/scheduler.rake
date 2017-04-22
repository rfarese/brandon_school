desc "This task is called by the Heroku scheduler for email notifications"
task :email_notification => :environment do
  tours = Tour.most_recent_by_house

  tours.each do |tour|
    house_name = tour.house.name
    args = { house_name: house_name, tour: tour }
    alerter = NoNewTourAlert.new(args)
    alerter.send_alert if alerter.should_send_alert?
  end
end

desc "Called by the Heroku scheduler for sending tours in progress email"
task :tours_in_progress_email => :environment do
  tours_in_progress = ToursInProgressReport.new
  tours_in_progress.csv_generator
  ToursInProgressMailer.new_report.deliver_later
  tours_in_progress.remove_csv_file
end
