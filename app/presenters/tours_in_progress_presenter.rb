class ToursInProgressPresenter
  attr_reader :houses, :tours, :student_checks, :data

  def initialize(houses)
    @houses = houses
    @tours = []
    @student_checks = []
    @data = {}
  end

  def build_data
    houses.each do |house|
      data[house.name] = {}
      add_tours(house)
    end
  end

  def add_tours(house)
    data[house.name][:tours] = []

    house.tours.each do |tour|
      data[house.name][:tours] << {
        id: tour.id,
        start_time: tour.created_at,
        status: tour.status,
        selfie: tour.selfie_pic,
        student_checks: add_student_checks(tour)
      }
    end
  end

  def add_student_checks(tour)
    student_checks = []

    tour.student_checks.each do |student_check|
      student_checks << {
        initials: student_check.initials,
        status: student_check.status,
        comment: student_check.comment
      }
    end

    student_checks
  end

end
