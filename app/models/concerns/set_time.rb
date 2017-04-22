module SetTime
  def current_time
    set_current_time
  end

  def set_current_time
    set_time_zone
    Time.zone.now
  end

  def set_time_zone
    Time.zone = 'Eastern Time (US & Canada)'
  end
end
