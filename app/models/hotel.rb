class Hotel < ApplicationRecord
  validates :name, :hotel_id, presence: true

  has_many :hotels_amenities
  has_many :amenities, through: :hotels_amenities

  belongs_to :location, optional: true
end
