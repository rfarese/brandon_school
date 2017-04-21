class ToursInProgressPresenter
  attr_reader :houses, :data

  def initialize(houses)
    @houses = houses
    @data = []
  end

  def build_data
    houses.each do |house|
      data << {
        name: house.name,
        tours: add_tours(house)
      }
    end
  end

  def add_tours(house)
    tours = []

    house.tours.each do |tour|
      tours << {
        id: tour.id,
        start_time: tour.created_at,
        status: tour.status,
        selfie: tour.selfie_pic,
        student_checks: add_student_checks(tour)
      }
    end

    tours
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
