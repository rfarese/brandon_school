class StudentCheckCacheManager
  attr_reader :student_checks, :tour_manager

  def initialize(student_checks)
    @student_checks = student_checks
  end

  def fetch_tour_manager_cache
    @tour_manager = Rails.cache.fetch("tour_manager_cache")
  end

  def update_cached_student_checks

  end

  def execute
    fetch_tour_manager_cache
    # update tour_manager.student_checks with student_checks
      # iterate over the tour_manager.student_checks
        # find the student_check that matches the current tour_manager student_check by id
    update_cached_student_checks
  end
end
