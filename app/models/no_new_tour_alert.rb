class NoNewTourAlert
  attr_reader :current_time, :house_name, :tour

  def initialize(args={})
    @house_name = args[:house_name]
    @tour = args[:tour]
    @current_time = set_current_time
  end

  def set_current_time
    set_time_zone
    Time.zone.now
  end

  def set_time_zone
    Time.zone = 'Eastern Time (US & Canada)'
  end

  def should_send_alert?
    correct_time? && time_passed_too_long?
  end

  def correct_time?
    current_time >= (Time.zone.parse "12:25 am") && current_time <= (Time.zone.parse "6:35 am")
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
