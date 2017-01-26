class Bed < ActiveRecord::Base
  belongs_to :room
  has_one :student
  validates :name, presence: true

  def house
    self.room.house
  end

  def empty?
    if self.student  == nil
      return true
    else
      return false
    end 
  end
end
