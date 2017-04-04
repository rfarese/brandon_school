class NoNewTourAlert
  attr_reader :current_time, :house_name, :tour

  def initialize(args={})
    @house_name = args[:house_name]
    @tour = args[:tour]
    @current_time = set_current_time
  end

  def is_edt?
    Time.now + 4.hour if Time.now.zone == "EDT"
  end

  def is_est?
    Time.now + 5.hour if Time.now.zone == "EST"
  end

  def set_current_time
    is_edt? || is_est?
  end

  def correct_time?
    between_11_and_12? || between_12_and_6?
  end

  def between_11_and_12?
    current_time >= (Time.parse "11:00 pm") && current_time <= (Time.parse "11:59:59 pm")
  end

  def between_12_and_6?
    current_time >= (Time.parse "12:00 am") && current_time <= (Time.parse "6:05 am")
  end

  def time_passed_too_long?
    too_long_since_incomplete_tour? || too_long_since_completed_tour?
  end

  def too_long_since_incomplete_tour?
    tour.incomplete? && ((current_time - tour.created_at) >= 4800)
  end

  def too_long_since_completed_tour?
    tour.complete? && ((current_time - tour.updated_at) >= 3600)
  end

  def send_alert
    NotificationMailer.new_notification(house_name).deliver_later
  end
end
