class StudentCheck < ActiveRecord::Base
  belongs_to :tour
  belongs_to :student
  enum complete_status: { incomplete: 0, complete: 1 }
  validates :status, presence: true, inclusion: { in: %w(asleep awake bathroom pass off_campus missing empty) }

  def bed
    self.student.bed
  end

  def room
    bed.room
  end

  def self.ids_by_house(houses)
    ids = []
    houses.each do |house|
      house.tours.each do |tour|
        tour.student_checks.each do |student_check|
          ids << student_check.id
        end
      end
    end
    ids.flatten
  end
end
