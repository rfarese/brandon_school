class Room < ActiveRecord::Base
  belongs_to :house
  has_many :beds 
  validates :name, presence: true
end
