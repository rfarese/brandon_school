class Room < ActiveRecord::Base
  belongs_to :house
  validates :name, presence: true 
end
