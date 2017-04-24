class House < ActiveRecord::Base
  has_many :permissions
  has_many :users, through: :permissions
  has_many :rooms, dependent: :destroy
  has_many :tours
  has_many :beds, dependent: :destroy
  validates :name, presence: true

  # I really feel like this should just be on the Tour model
  # and we should just includes(:house) for the scope on the Tour model...
  scope :tours_today, -> { includes(:tours).joins(:tours).merge(Tour.today) }

  # I don't even think we are using this scope...I think we are just using
  # last_night scope on the Tour model 
  scope :last_night_tours, -> { includes(:tours).joins(:tours).merge(Tour.last_night) }

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |house|
        csv << house.attributes.values_at(*column_names)
      end
    end
  end
end
