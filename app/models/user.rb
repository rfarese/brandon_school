class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :role, inclusion: { in: %w(admin overnight_staff) }, presence: true
  has_many :houses

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
