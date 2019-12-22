class HotelsBookingCondition < ApplicationRecord
  belongs_to :hotel
  belongs_to :booking_condition
end
