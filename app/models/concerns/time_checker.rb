module TimeChecker
  def set_current_time
    set_time_zone
    Time.zone.now
  end

  def set_time_zone
    Time.zone = 'Eastern Time (US & Canada)'
  end

  def correct_time?(start_time, end_time)
    current_time >= start_time && current_time <= end_time
  end
end
