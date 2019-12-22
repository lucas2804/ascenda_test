class Amenity < ApplicationRecord
  enum category: { general: 1, room: 2 }
end
