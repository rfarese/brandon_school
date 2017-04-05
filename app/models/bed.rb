class Bed < ActiveRecord::Base
  belongs_to :room
  belongs_to :house
  validates :name, presence: true
end
