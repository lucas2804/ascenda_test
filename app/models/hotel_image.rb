class HotelImage < ApplicationRecord
  validates :link, presence: true
  enum category: { site: 1, room: 2, amenities: 3 }
end
