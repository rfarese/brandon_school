class House < ActiveRecord::Base
  has_many :permissions
  has_many :users, through: :permissions
  has_many :rooms
  has_many :tours
  validates :name, presence: true
end
