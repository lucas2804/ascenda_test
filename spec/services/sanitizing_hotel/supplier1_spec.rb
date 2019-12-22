require 'rails_helper'

RSpec.describe SanitizingHotel::Supplier1 do
  let(:service) { SanitizingHotel::Supplier1.new }
  let(:fake_response) { '{}' }

  describe '#fetch_request' do
    let(:fake_response) { File.open('test/fixtures/files/supplier1/supplier1.json').read }

    it 'should create 3 hotels with specified params' do
      parse_fake_response = JSON.parse(fake_response)
      expect(service).to receive(:fetch_request).and_return(parse_fake_response)
      expect(service).to receive(:update_hotel_amenities).exactly(3).times

      service.execute
      expect(Hotel.count).to eq(3)
      expect(Location.count).to eq(3)
    end
  end

  describe '#find_or_create_hotel!' do
    before do
      parse_fake_response = JSON.parse(fake_response)
      expect(service).to receive(:fetch_request).and_return(parse_fake_response)
    end

    context 'hotel params contain space at head and end lines' do
      let(:fake_response) { File.open('test/fixtures/files/supplier1/need_strip_hotel.json').read }
      it 'should sanitize data, strip' do
        service.execute
        hotel = Hotel.first
        expect(hotel.hotel_id[0]).not_to eq(' ')
        expect(hotel.name[0]).not_to eq(' ')
        expect(hotel.description[0]).not_to eq(' ')
        expect(hotel.hotel_id.last).not_to eq(' ')
        expect(hotel.description.last).not_to eq(' ')
        expect(hotel.name.last).not_to eq(' ')

        location = hotel.location
        expect(location.address[0]).not_to eq(' ')
        expect(location.country[0]).not_to eq(' ')
        expect(location.postal_code[0]).not_to eq(' ')
        expect(location.address.last).not_to eq(' ')
        expect(location.country.last).not_to eq(' ')
        expect(location.postal_code.last).not_to eq(' ')
      end
    end

    context 'hotel params contain nil values but name, hotel_id, address' do
      let(:fake_response) { File.open('test/fixtures/files/supplier1/need_ignore_nil.json').read }
      it 'should create hotel without not important data normally' do
        service.execute
        expect(Hotel.count).to eq(1)
      end
    end
  end

  describe '#update_amenities!' do
    let(:amenity_params) { { 'Facilities' => ['AzzBbb WiFi C'] } }
    it 'should call update_sanitized_amenities! from Base' do
      expect(service).to receive(:update_sanitized_amenities!).with(amenity_params['Facilities'], anything).and_call_original
      service.send(:update_amenities!, amenity_params)

      expect(Amenity.count).to eq(1)
      expect(Amenity.first.name).to eq('azz bbb wifi c')
    end
  end
end
