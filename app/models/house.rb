class House < ActiveRecord::Base
  has_many :permissions
  has_many :users, through: :permissions
  has_many :rooms, dependent: :destroy
  has_many :tours
  validates :name, presence: true

  # instead of iterating over rooms and then over beds, try this...
  # add a class method onto the Bed model
  # have that class method return all the beds for a given house
  # inside the beds method below (in the house model), pass the house (self)
  # as a parameter to the bed class method

  scope :tours_today, -> { includes(:tours).joins(:tours).merge(Tour.today) }

  def beds
    Bed.by_houses(self)
  end
end
