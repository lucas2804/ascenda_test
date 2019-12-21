require 'rails_helper'

RSpec.describe SanitizingHotel::Supplier1 do
  let(:service) { SanitizingHotel::Supplier1.new }
  let(:fake_response) { '{}' }

  describe '#fetch_request' do
    let(:fake_response) { File.open('test/fixtures/files/supplier1/supplier1.json').read }

    before do
      parse_fake_response = JSON.parse(fake_response)
      expect(service).to receive(:fetch_request).and_return(parse_fake_response)
    end
    it 'should create 3 hotels with specified params' do
      service.execute
      expect(Hotel.count).to eq(3)
    end
  end

  describe '#find_or_create_hotel!' do
    let(:fake_response) { File.open('test/fixtures/files/supplier1/need_strip_hotel.json').read }

    before do
      parse_fake_response = JSON.parse(fake_response)
      expect(service).to receive(:fetch_request).and_return(parse_fake_response)
    end
    context 'hotel params contain space at head and end lines' do
      it 'should sanitize data, strip' do
        service.execute
        hotel = Hotel.first
        expect(hotel.hotel_id[0]).not_to eq(' ')
        expect(hotel.description[0]).not_to eq(' ')
        expect(hotel.address[0]).not_to eq(' ')
        expect(hotel.name[0]).not_to eq(' ')
        expect(hotel.country[0]).not_to eq(' ')
        expect(hotel.postal_code[0]).not_to eq(' ')

        expect(hotel.hotel_id.last).not_to eq(' ')
        expect(hotel.description.last).not_to eq(' ')
        expect(hotel.address.last).not_to eq(' ')
        expect(hotel.name.last).not_to eq(' ')
        expect(hotel.country.last).not_to eq(' ')
        expect(hotel.postal_code.last).not_to eq(' ')
      end
    end

    context 'hotel params contain nil values but name, hotel_id, address' do
      it 'should create hotel without not important data normally' do
        service.execute
        expect(Hotel.count).to eq(1)
      end
    end
  end

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

  describe '#find_or_create_amenities!' do
    it 'should change camelcase to normal words and strip' do
      amenity_params = { 'Facilities' => [' DryCleaning ', '  BusinessCenter  '] }
      service.send(:find_or_create_amenities!, amenity_params)
      expect(Amenity.first.name).to eq('dry cleaning')
      expect(Amenity.last.name).to eq('business center')
    end

    it 'should not sanitize CONCATENATE_WORDS as WiFi' do
      amenity_params = { 'Facilities' => [' WiFi '] }
      service.send(:find_or_create_amenities!, amenity_params)
      expect(Amenity.first.name).to eq('wifi')
    end

    it 'should check each word then ignore if in CONCATENATE_WORDS' do
      amenity_params = { 'Facilities' => ['AzzBbb WiFi C'] }
      service.send(:find_or_create_amenities!, amenity_params)
      expect(Amenity.first.name).to eq('azz bbb wifi c')
    end

    it 'should create amenity with category general' do
      amenity_params = { 'Facilities' => ['AzzBbb WiFi C'] }
      service.send(:find_or_create_amenities!, amenity_params)
      expect(Amenity.first.category).to eq(Amenity.categories[:general])
    end
  end
end
