class Tour < ActiveRecord::Base
  belongs_to :house
  belongs_to :selfie
  has_many :student_checks
  # mount_uploader :selfie, SelfieUploader
  enum status: { incomplete: 0, complete: 1 }

  scope :today, -> { includes(:student_checks).where(updated_at: (Time.now - 24.hours)..Time.now) }

  scope :last_night, -> {
    includes([:student_checks, :house]).
    where(updated_at: ((Time.parse "11:00 pm") - 24.hours)..Time.now)
  }

  # def selfie_pic
  #   selfie.file.url
  # end

  def rooms
    house.rooms
  end

  def complete?
    student_checks.where(complete_status: 1).count == house.beds.count
  end

  def current_room_complete?
    incomplete_student_checks.count == 0
  end

  def incomplete_student_checks
    self.student_checks.where(complete_status: 0)
  end

  def build_student_checks
    StudentCheckBuilder.new(self).generate
  end

  def self.most_recent_by_house
    Tour.includes(:house).where(id: (Tour.group(:house_id).maximum(:id).values))
  end
end
