class Amenity < ApplicationRecord
  enum categories: { general: 1, room: 2 }
end
