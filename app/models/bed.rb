class Bed < ActiveRecord::Base
  belongs_to :room
  belongs_to :house, counter_cache: true 
  validates :name, presence: true
end
