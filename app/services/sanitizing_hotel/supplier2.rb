module SanitizingHotel
  class Supplier2 < Base
    def execute
      hotels = fetch_request(url)
      hotels.map do |hotel_params|
        hotel = find_or_create_hotel!(hotel_params)
        amenities = update_amenities!(hotel_params)
        update_hotel_amenities(hotel, amenities)
        update_booking_conditions(hotel.id, hotel_params['booking_conditions'])
        update_hotel_images(hotel, hotel_params)
      end
    end

    private

    def update_hotel_images(hotel, hotel_params)
      hotel_params['images']['rooms']&.map do |img_hash|
        hotel_image = HotelImage.find_or_create_by({ link: img_hash['link'], category: HotelImage.categories[:room], hotel_id: hotel.id })
        hotel_image.update(description: img_hash['caption'])
      end

      hotel_params['images']['site']&.map do |img_hash|
        hotel_image = HotelImage.find_or_create_by({ link: img_hash['link'], category: HotelImage.categories[:site], hotel_id: hotel.id })
        hotel_image.update(description: img_hash['caption'])
      end
    end

    def update_amenities!(hotel_params)
      general_amenities = update_sanitized_amenities!(hotel_params['amenities']['general'], Amenity.categories[:general])
      room_amenities = update_sanitized_amenities!(hotel_params['amenities']['room'], Amenity.categories[:room])
      general_amenities + room_amenities
    end

    def find_or_create_hotel!(hotel_params)
      hotel = Hotel.find_or_initialize_by(hotel_id: hotel_params['hotel_id']&.strip)
      params = {
        hotel_id: hotel_params['hotel_id']&.strip,
        name: hotel_params['hotel_name']&.strip,
        address: hotel_params['location']&.fetch('address', nil)&.strip,
        detail: hotel_params['details']&.strip,
        destination_id: hotel_params['destination_id'],
        country: hotel_params['location']&.fetch('country', nil)&.strip
      }
      params = params.reject { |k, v| v == nil }
      hotel.update_attributes!(params)
      hotel.reload
    end

    def url
      'https://api.myjson.com/bins/1fva3m'
    end
  end
end
