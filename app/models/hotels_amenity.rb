class HotelsAmenity < ApplicationRecord
  belongs_to :hotel
  belongs_to :amenity
end
