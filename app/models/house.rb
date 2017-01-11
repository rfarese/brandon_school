class House < ActiveRecord::Base
  has_many :permissions
  has_many :users, through: :permissions
  has_many :rooms
  validates :name, presence: true
end
