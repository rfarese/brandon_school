class LastNightsToursReport
  attr_reader :tours, :report
  include TimeChecker
  include TmpAide

  def initialize()
    @tours = Tour.last_night
  end

  def start_time
    Time.zone.parse "4:05 am"
    # Time.zone.parse "8:55 am"
  end

  def end_time
    Time.zone.parse "9:05 am"
  end

  def right_time?
    correct_time?(start_time, end_time)
  end

  def student_checks
    checks = []
    tours.each do |tour|
      checks << tour.student_checks
    end
    checks.flatten
  end

  def csv_generator
    path("last_nights_tours.csv")
    build_csv
    @report = open_file
  end

  def build_csv
    CSV.open(tmp_path, "wb") do |csv|
      csv << ["House", "Tour Start Time", "Tour Status", "Bed Check Initials", "Bed Check Status", "Bed Check Comment"]
      student_checks.each do |student_check|
        tour = student_check.tour
        house = tour.house
        csv << [house.name, tour.created_at, tour.status, student_check.initials, student_check.status, student_check.comment]
      end
    end
  end

  def email_report
    LastNightsToursReportMailer.new_report.deliver_later
  end
end
