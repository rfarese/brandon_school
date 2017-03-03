desc "This task is called by the Heroku scheduler for email notifications"
task :email_notification => :environment do
  houses = House.all
  houses.each do |house|
    tour = house.tours.last

    if tour.complete? && ((Time.now - tour.updated_at) >= 3600)
      NotificationMailer.new_notification(house.name).deliver_later
    end

    if tour.incomplete? && ((Time.now - tour.created_at) >= 4800)
      NotificationMailer.new_notification(house.name).deliver_later
    end
  end
end
