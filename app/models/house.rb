class House < ActiveRecord::Base
  has_many :permissions
  has_many :users, through: :permissions
  has_many :rooms, dependent: :destroy
  has_many :tours
  has_many :beds, dependent: :destroy
  validates :name, presence: true

  scope :tours_today, -> { includes(:tours).joins(:tours).merge(Tour.today) }

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |house|
        csv << house.attributes.values_at(*column_names)
      end
    end
  end
end
