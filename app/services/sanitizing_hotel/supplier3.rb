module SanitizingHotel
  class Supplier3 < Base
    def execute
      hotels = fetch_request(url)
      hotels.map do |hotel_params|
        hotel = find_or_create_hotel!(hotel_params)
        amenities = update_amenities!(hotel_params)
        update_hotel_amenities(hotel, amenities)
        update_hotel_images(hotel, hotel_params)
      end
    end

    private

    def update_hotel_images(hotel, hotel_params)
      hotel_params['images']&.fetch('rooms', nil)&.map do |img_hash|
        hotel_image = HotelImage.find_or_create_by({ link: img_hash['url'], category: HotelImage.categories[:room], hotel_id: hotel.id })
        hotel_image.update(description: img_hash['description'])
      end

      hotel_params['images']&.fetch('amenities', nil)&.map do |img_hash|
        hotel_image = HotelImage.find_or_create_by({ link: img_hash['url'], category: HotelImage.categories[:amenities], hotel_id: hotel.id })
        hotel_image.update(description: img_hash['description'])
      end
    end

    def update_amenities!(hotel_params)
      update_sanitized_amenities!(hotel_params['amenities'], Amenity.categories[:general])
    end

    def find_or_create_hotel!(hotel_params)
      hotel = Hotel.find_or_initialize_by(hotel_id: hotel_params['id']&.strip)

      params = {
        name: hotel_params['name']&.strip,
        address: hotel_params['address']&.strip,
        info: hotel_params['info']&.strip,
        longitude: hotel_params['lng']&.to_f,
        latitude: hotel_params['lat']&.to_f,
        destination_id: hotel_params['destination'],
      }
      params = params.reject { |k, v| v == nil }
      hotel.update_attributes!(params)
      hotel.reload
    end

    def url
      'https://api.myjson.com/bins/j6kzm'
    end
  end
end
