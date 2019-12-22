require 'rails_helper'

RSpec.describe SanitizingHotel::Base do
  let(:service) { SanitizingHotel::Base.new }
  let(:general) { Amenity.categories[:general] }
  let(:room) { Amenity.categories[:room] }
  let(:fake_response) { '{}' }

  describe '#update_hotel_amenities' do
    let(:hotel) { create(:hotel) }
    let(:amenities) { create_list(:amenity, 2) }
    it 'should create hotel with relate amenities' do
      service.send(:update_hotel_amenities, hotel, amenities)

      hotel = Hotel.first
      expect(hotel.amenities.size).to eq(2)
      expect(HotelsAmenity.count).to eq(2)
    end
  end

  describe '#update_amenities!' do
    it 'should change camelcase to normal words and strip' do
      amenity_params = [' DryCleaning ', '  BusinessCenter  ']
      service.send(:update_sanitized_amenities!, amenity_params, general)
      expect(Amenity.first.name).to eq('dry cleaning')
      expect(Amenity.last.name).to eq('business center')
    end

    it 'should not sanitize CONCATENATE_WORDS as WiFi' do
      amenity_params = [' WiFi ']
      service.send(:update_sanitized_amenities!, amenity_params, general)
      expect(Amenity.first.name).to eq('wifi')
    end

    it 'should check each word then ignore if in CONCATENATE_WORDS' do
      amenity_params = ['AzzBbb WiFi C']
      service.send(:update_sanitized_amenities!, amenity_params, general)
      expect(Amenity.first.name).to eq('azz bbb wifi c')
    end

    it 'should create amenity with category general' do
      amenity_params = ['AzzBbb WiFi C']
      service.send(:update_sanitized_amenities!, amenity_params, general)
      expect(Amenity.first.category).to eq('general')
    end
  end
end
