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
task :last_nights_tours_report => :environment do
  generator = LastNightsToursReport.new

  if generator.right_time?
    generator.csv_generator
    generator.email_report
    generator.remove_file
  end
end
