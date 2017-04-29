class NoNewTourAlert
  attr_reader :house_name, :tour, :current_time
  include TimeChecker

  def initialize(args={})
    @house_name = args[:house_name]
    @tour = args[:tour]
    @current_time = set_current_time
  end

  def start_time
    Time.zone.parse "12:25 am"
  end

  def end_time
    Time.zone.parse "6:35 am"
  end

  def should_send_alert?
    correct_time?(start_time, end_time) && time_passed_too_long?
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
