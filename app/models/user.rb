class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true
  validates :role, inclusion: { in: %w(admin overnight_staff) }, presence: true

  attr_accessor :login 
end
