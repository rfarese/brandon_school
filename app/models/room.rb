class Room < ActiveRecord::Base
  # add unique qrcode identifier column to room
  # generate a unique qrcode identifier number
  # use this unique qrcode identifier number to generate the qr code
  attr_accessor :complete

  belongs_to :house
  has_many :beds
  has_many :student_checks
  has_one :qrcode, dependent: :destroy
  validates :name, presence: true
  validates :house_id, presence: true
  after_save :create_new_qr_code

  def create_new_qr_code
    qr_code = Qrcode.new
    qr_code.room_id = self.id
    qr_code.image_builder(self.qrcode_identifier)
    qr_code.save
    self.qrcode = qr_code
  end

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

  def generate_qrcode_identifier
    Room.maximum(:qrcode_identifier) + 1
  end
end
