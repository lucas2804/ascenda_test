module SanitizingHotel
  class Base
    CONCATENATE_WORDS = %w(wifi bathtub)

    def update_booking_conditions(hotel_id, booking_conditions)
      booking_conditions&.map do |condition|
        BookingCondition.find_or_create_by({ hotel_id: hotel_id, condition: condition })
      end
    end

    def update_sanitized_amenities!(amenity_params, category)
      amenity_params&.map do |amenity_name|
        Amenity.find_or_create_by({ name: downcase_concatenate_words(amenity_name), category: category })
      end
    end

    def fetch_request(url)
      response = ::RestClient::Request.execute(method: :get, url: url)
      JSON.parse(response.body)
    rescue StandardError => error
      message = 'Can not fetch data from Supplier'
      Rails.logger.error "#{message}  #{error}"
    end

    def downcase_concatenate_words(words)
      words = words.strip.split(' ').map do |word|
        if word.downcase.in?(CONCATENATE_WORDS)
          word.downcase
        else
          word
        end
      end
      words.join(' ').strip.underscore.gsub('_', ' ')
    end

    def update_hotel_amenities(hotel, amenities)
      exist_hotel_amenity_names = hotel.amenities.map(&:name)
      amenities = amenities&.select do |amenity|
        amenity unless amenity.name.in? exist_hotel_amenity_names
      end
      hotel.amenities << amenities if amenities.present?
    end
  end
end
