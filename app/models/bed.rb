class Bed < ActiveRecord::Base
  belongs_to :room, counter_cache: true 
  belongs_to :house, counter_cache: true
  validates :name, presence: true
end
