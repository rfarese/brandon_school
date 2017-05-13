module TourStatusHelper
  def tour_status(status, start_time)
    if under_one_hour(start_time) && status == "incomplete"
      "In progress"
    elsif over_one_hour(start_time) && status == "incomplete"
      "Incomplete"
    else
      "Complete"
    end
  end

  def under_one_hour(start_time)
    (Time.now - start_time) < 3600
  end

  def over_one_hour(start_time)
    (Time.now - start_time) >= 3600
  end
end
