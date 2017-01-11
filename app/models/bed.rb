class Bed < ActiveRecord::Base
  belongs_to :room
  has_one :student
  validates :name, presence: true
end
