require 'rails_helper'

RSpec.describe SanitizingHotel::Supplier2 do
  let(:service) { SanitizingHotel::Supplier2.new }
  let(:fake_response) { '{}' }

  describe '#fetch_request' do
    let(:fake_response) { File.open('test/fixtures/files/supplier2/supplier2.json').read }

    before do
      parse_fake_response = JSON.parse(fake_response)
      expect(service).to receive(:fetch_request).and_return(parse_fake_response)
    end
    it 'should create 2 hotels with specified params' do
      service.execute
      expect(Hotel.count).to eq(2)
    end
  end

  describe '#find_or_create_hotel!' do
    before do
      parse_fake_response = JSON.parse(fake_response)
      expect(service).to receive(:fetch_request).and_return(parse_fake_response)
    end
    context 'hotel params contain space at head and end lines' do
      let(:fake_response) { File.open('test/fixtures/files/supplier2/need_strip_hotel.json').read }
      it 'should sanitize data, strip' do
        service.execute
        hotel = Hotel.first
        expect(hotel.hotel_id[0]).not_to eq(' ')
        expect(hotel.detail[0]).not_to eq(' ')
        expect(hotel.address[0]).not_to eq(' ')
        expect(hotel.name[0]).not_to eq(' ')
        expect(hotel.country[0]).not_to eq(' ')

        expect(hotel.hotel_id.last).not_to eq(' ')
        expect(hotel.detail.last).not_to eq(' ')
        expect(hotel.address.last).not_to eq(' ')
        expect(hotel.name.last).not_to eq(' ')
        expect(hotel.country.last).not_to eq(' ')
      end
    end

    context 'hotel params contain nil values but name, hotel_id, address' do
      let(:fake_response) { File.open('test/fixtures/files/supplier2/need_ignore_nil.json').read }
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

  describe '#update_amenities!!' do
    let(:amenity_params) {
      {
        "amenities" => {
          "general" => [
            "outdoor pool",
          ],
          "room" => [
            "coffee machine",
          ]
        }
      }
    }
    it 'should call update_sanitized_amenities!' do
      expect(service).to receive(:update_sanitized_amenities!).with(anything, Amenity.categories[:general]).and_call_original
      expect(service).to receive(:update_sanitized_amenities!).with(anything, Amenity.categories[:room]).and_call_original

      service.send(:update_amenities!, amenity_params)
      expect(Amenity.count).to eq(2)
      expect(Amenity.general.first.name).to eq('outdoor pool')
      expect(Amenity.room.first.name).to eq('coffee machine')
    end
  end
end
