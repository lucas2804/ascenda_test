class Hotel < ApplicationRecord
  validates :name, :hotel_id, :address, presence: true
end
