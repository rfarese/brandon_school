desc "This task is called by the Heroku scheduler for email notifications"
task :email_notification => :environment do
  houses = House.all
  houses.each do |house|
    tour = house.tours.last
    current_time = Time.now
    # email alerts start at 11:00 pm and end at 6:00 am the next day

    # if the current_time is after 6:00 am and before 11:00 pm, what do we want the start_time and end_time to be?
    if current_time > (Time.parse "6:00 am") && current_time < (Time.parse "11:00 pm")
      # do nothing...
    end 
    # if the current_time is after 11:00 pm and before 11:59 pm, what do we want the start_time and end_time to be?
    # if the current_time is after (or equal too) 12:00 am and before 6:00 am, what should start_time and end_time be?

    if current_time >= (Time.parse "12:00 am") && current_time <= (Time.parse "7:00 am")

    end
    start_time = Time.parse "11:00 pm"
    end_time = (Time.parse "12:00 am") + 29.hours

    # start_time and end time will be wrong after 12:00...
    # at midnight or later end_time will be

    if current_time > start_time && current_time < end_time
      if tour.complete? && ((current_time - tour.updated_at) >= 3600)
        NotificationMailer.new_notification(house.name).deliver_later
      end

      if tour.incomplete? && ((current_time - tour.created_at) >= 4800)
        NotificationMailer.new_notification(house.name).deliver_later
      end
    end
  end
end
