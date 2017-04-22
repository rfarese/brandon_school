class ToursInProgressReport
  attr_reader :tours, :report, :tmp_path
  include SetTime

  def initialize()
    @tours = Tour.last_night
  end

  def correct_time?
    current_time >= (Time.zone.parse "8:55 am") && current_time <= (Time.zone.parse "9:05 am")
  end

  def student_checks
    checks = []
    tours.each do |tour|
      checks << tour.student_checks
    end
    checks.flatten
  end

  def csv_generator
    @tmp_path = Rails.root.join('tmp', "last_nights_tours.csv")
    build_csv
    open_csv_file
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
    ToursInProgressMailer.new_report.deliver_later
  end

  def open_csv_file
    File.open(tmp_path) do |file|
      @report = file
    end
  end

  def remove_csv_file
    File.delete(tmp_path)
  end
end
