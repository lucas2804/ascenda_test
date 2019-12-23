class HotelSerializer < ActiveModel::Serializer
  attributes :id, :destination_id, :name, :location, :description,
             :amenities, :images,
             :booking_conditions

  belongs_to :location

  def id
    object.hotel_id
  end

  def amenities
    {
      'general': object.amenities.general&.map { |obj| AmenitySerializer.new(obj) },
      'room': object.amenities&.map { |obj| AmenitySerializer.new(obj) },
    }
  end

  def images
    {
      rooms: object.hotel_images.room&.map { |obj| HotelImageSerializer.new(obj) },
      site: object.hotel_images.site&.map { |obj| HotelImageSerializer.new(obj) },
      amenities: object.hotel_images.amenities&.map { |obj| HotelImageSerializer.new(obj) },
    }
  end

  def booking_conditions
    object.booking_conditions.map(&:condition)
  end
end
