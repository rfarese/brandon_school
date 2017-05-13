class Room < ActiveRecord::Base
  attr_accessor :complete

  belongs_to :house, counter_cache: true
  has_many :beds, dependent: :destroy
  has_many :student_checks, dependent: :destroy 
  has_one :qrcode, dependent: :destroy
  validates :name, presence: true
  validates :house_id, presence: true

  def student_checks_by_room_and_tour(tour)
    StudentCheck.by_room_and_tour(tour_id: tour.id, room_id: self.id)
  end

  def complete_checker(tour)
    student_checks = student_checks_by_room_and_tour(tour)
    if student_checks_incomplete?(student_checks)
      @complete = false
    else
      @complete = true
    end
  end

  def student_checks_incomplete?(student_checks)
    student_checks.any? { |student_check| student_check.complete_status == "incomplete" }
  end
end
