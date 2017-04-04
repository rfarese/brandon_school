desc "This task is called by the Heroku scheduler for email notifications"
task :email_notification => :environment do
  tours = Tour.most_recent_by_house

  tours.each do |tour|
    house_name = tour.house.name
    args = { house_name: house_name, tour: tour }
    alerter = NoNewTourAlert.new(args)

    if alerter.correct_time? && alerter.time_passed_too_long?
      alerter.send_alert
    end
    binding.pry
  end
end
