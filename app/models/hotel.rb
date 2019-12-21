class Hotel < ApplicationRecord
  validates :name, :hotel_id, :address, presence: true

  has_many :hotels_amenities
  has_many :amenities, through: :hotels_amenities
end
