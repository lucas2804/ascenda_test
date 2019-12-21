module SanitizingHotel
  class Supplier1

    CONCATENATE_WORDS = ['wifi']

    def execute
      hotels = fetch_request
      hotels.map do |hotel_params|
        hotel = find_or_create_hotel!(hotel_params)
      end
    end

    private

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

    def fetch_request
      response = ::RestClient::Request.execute(method: :get, url: url)
      JSON.parse(response.body)
    rescue StandardError => error
      message = 'Can not fetch data from Supplier1'
      Rails.logger.error "#{message}  #{error}"
    end
  end
end
