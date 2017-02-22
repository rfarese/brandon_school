class Bed < ActiveRecord::Base
  belongs_to :room
  validates :name, presence: true

  def house
    room.house
  end
end
