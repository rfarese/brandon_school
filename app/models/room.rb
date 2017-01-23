class Room < ActiveRecord::Base
  belongs_to :house
  has_many :beds
  has_one :qrcode
  validates :name, presence: true
  after_save :create_new_qr_code

  def create_new_qr_code
    qr_code = Qrcode.new
    qr_code.room_id = self.id
    qr_code.build_image
    qr_code.save
    self.qrcode = qr_code
  end

  def students
    s = []
    self.beds.each do |bed|
      s << bed.student if bed.student
    end
    s
  end
end
