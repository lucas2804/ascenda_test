module SanitizingHotel
  class Supplier1 < Base
    def execute
      hotels = fetch_request(url)
      hotels.map do |hotel_params|
        hotel = find_or_create_hotel!(hotel_params)
        update_location!(hotel, hotel_params)
        amenities = update_amenities!(hotel_params)
        update_hotel_amenities(hotel, amenities)
      end
    end

    private

    def update_amenities!(hotel_params)
      update_sanitized_amenities!(hotel_params['Facilities'], Amenity.categories[:general])
    end

    def update_location!(hotel, hotel_params)
      location_params = {
        address: hotel_params['Address']&.strip,
        lng: hotel_params['Longitude']&.to_f,
        lat: hotel_params['Latitude']&.to_f,
        postal_code: hotel_params['PostalCode']&.strip,
        country: hotel_params['Country']&.strip,
        city: hotel_params['City']&.strip,
      }
      location_params = location_params.reject { |k, v| v == nil }
      update_sanitize_location(hotel, location_params)
    end

    def find_or_create_hotel!(hotel_params)
      hotel = Hotel.find_or_initialize_by(hotel_id: hotel_params['Id']&.strip)
      params = {
        name: hotel_params['Name']&.strip,
        description: hotel_params['Description']&.strip,
        destination_id: hotel_params['DestinationId']&.to_i,
      }
      params = params.reject { |k, v| v == nil }
      hotel.update_attributes!(params)
      hotel.reload
    end

    def url
      'https://api.myjson.com/bins/gdmqa'
    end
  end
end
