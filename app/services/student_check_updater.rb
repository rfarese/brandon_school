class StudentCheckUpdater
  attr_reader :student_checks_params, :student_check,
              :student_check_params, :initials, :status,
              :comment, :tour, :rooms, :current_room,
              :current_student_checks, :tour_manager, :qrcode_identifier

  def initialize(student_checks_params, tour)
    @tour = tour
    @student_checks_params = student_checks_params
    @qrcode_identifier = student_checks_params.first[:qrcode_identifier]
    @student_checks = []
  end

  def execute
    create_tour_manager
    set_current_student_checks
    student_checks_params.each do |student_check_params|
      @student_check_params = student_check_params
      find_student_check
      set_student_check_attributes
      update_student_check
      is_student_check_valid?
      add_current_room
      add_rooms
    end
  end

  def create_tour_manager
    @tour_manager = TourManager.new(tour, qrcode_identifier)
    @tour_manager.organize
  end

  def set_current_student_checks
    @current_student_checks = tour_manager.current_student_checks
  end

  def find_student_check
    @student_check = current_student_checks.find { |student_check| student_check.id == student_check_params[:id].to_i }
  end

  def set_student_check_attributes
    @initials = student_check_params[:initials]
    @status = student_check_params[:status]
    @comment = student_check_params[:comment]
  end

  def update_student_check
    student_check.assign_attributes(
      initials: initials, status: status, comment: comment, tour_id: tour.id
    )
  end

  def is_student_check_valid?
    if student_check.valid?
      set_student_check_complete_status
    end
  end

  def set_student_check_complete_status
    student_check.complete_status = 1
    save_student_check
  end

  def save_student_check
    student_check.save
  end

  def add_current_room
    @current_room = tour_manager.current_room
  end

  def add_rooms
    @rooms = tour_manager.rooms
  end
end
