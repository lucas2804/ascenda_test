module SanitizingHotel
  class Supplier1
    include Helper

    def execute
      hotels = fetch_request(url)
      hotels.map do |hotel_params|
        hotel = find_or_create_hotel!(hotel_params)
        amenities = find_or_create_amenities!(hotel_params)
        update_hotel_amenities(hotel, amenities)
      end
    end

    private

    def update_hotel_amenities(hotel, amenities)
      exist_hotel_amenity_names = hotel.amenities.map(&:name)
      amenities = amenities.select do |amenity|
        amenity unless amenity.name.in? exist_hotel_amenity_names
      end
      hotel.amenities << amenities if amenities.present?
    end

    def find_or_create_amenities!(hotel_params)
      hotel_params['Facilities']&.map do |amenity_name|
        Amenity.find_or_create_by(
          { name: downcase_concatenate_words(amenity_name),
            category: Amenity.categories[:general] })
      end
    end

    def find_or_create_hotel!(hotel_params)
      hotel = Hotel.find_or_initialize_by(hotel_id: hotel_params['Id'])
      params = {
        hotel_id: hotel_params['Id']&.strip,
        name: hotel_params['Name']&.strip,
        description: hotel_params['Description']&.strip,
        address: hotel_params['Address']&.strip,
        longitude: hotel_params['Longitude']&.to_f,
        latitude: hotel_params['Latitude']&.to_f,
        postal_code: hotel_params['PostalCode']&.strip,
        destination_id: hotel_params['DestinationId']&.to_i,
        city: hotel_params['City']&.strip,
        country: hotel_params['Country']&.strip,
      }
      hotel.update_attributes!(params)
      hotel.reload
    end

    def url
      'https://api.myjson.com/bins/gdmqa'
    end
  end
end
