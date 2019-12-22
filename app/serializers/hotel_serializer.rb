class HotelSerializer < ActiveModel::Serializer
  attributes :id, :destination_id, :name, :location, :description,
             :amenities, :images,
             :booking_conditions

  def id
    object.hotel_id
  end

  def amenities
    {
      'general': object.amenities.general,
      'room': object.amenities.room,
    }
  end

  def images
    {
      rooms: object.hotel_images.room,
      site: object.hotel_images.site,
      amenities: object.hotel_images.amenities,
    }
  end

  def booking_conditions
    object.booking_conditions.map(&:condition)
  end
end
