class StudentCheckUpdater
  attr_reader :student_checks_params, :student_check,
              :student_check_params, :initials, :status,
              :comment, :tour_id, :rooms, :current_room,
              :cached_student_checks, :tour_manager

  def initialize(student_checks_params, tour_id)
    @tour_id = tour_id
    @student_checks_params = student_checks_params
    @student_checks = []
  end

  def execute
    set_cached_student_checks
    student_checks_params.each do |student_check_params|
      @student_check_params = student_check_params
      find_student_check
      set_student_check_attributes
      update_student_check
      is_student_check_valid?
      update_tour_manager_cache
      add_current_room
      add_rooms
    end
  end

  def set_cached_student_checks
    # the error is coming from here
    # current_student_checks is an undefined method on nil:NillClass
    @cached_student_checks = Rails.cache.fetch("tour_#{tour_id}_manager_cache").current_student_checks
  end

  def find_student_check
    @student_check = cached_student_checks.find { |student_check| student_check.id == student_check_params[:id].to_i }
  end

  def set_student_check_attributes
    @initials = student_check_params[:initials]
    @status = student_check_params[:status]
    @comment = student_check_params[:comment]
  end

  def update_student_check
    student_check.assign_attributes(
      initials: initials, status: status, comment: comment, tour_id: tour_id
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

  def update_tour_manager_cache
    set_tour_manager
    remove_old_tour_manager_cache
    add_new_tour_manager_cache
  end

  def set_tour_manager
    @tour_manager = Rails.cache.fetch("tour_#{tour_id}_manager_cache")
  end

  def remove_old_tour_manager_cache
    Rails.cache.delete("tour_#{tour_id}_manager_cache")
  end

  def add_new_tour_manager_cache
    Rails.cache.fetch("tour_#{tour_id}_manager_cache", expires_in: 1.hour) do
      tour_manager
    end
  end

  def add_current_room
    @current_room = tour_manager.current_room
  end

  def add_rooms
    @rooms = tour_manager.rooms
  end
end
