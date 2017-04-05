class Bed < ActiveRecord::Base
  belongs_to :room
  validates :name, presence: true

  scope :by_houses, -> (houses) { joins(room: :house).where(houses: { id: houses }) }

  def house
    room.house
  end
end
