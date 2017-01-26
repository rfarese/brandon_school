class House < ActiveRecord::Base
  has_many :permissions
  has_many :users, through: :permissions
  has_many :rooms, dependent: :destroy 
  has_many :tours
  validates :name, presence: true

  def beds
    b = []
    self.rooms.each do |room|
      room.beds.each do |bed|
        b << bed
      end
    end
    b
  end

  def students
    s = []
    self.beds.each do |bed|
      s << bed.student if bed.student
    end
    s
  end

end
