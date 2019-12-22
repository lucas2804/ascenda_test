require 'rails_helper'

RSpec.describe SanitizingHotel::Supplier3 do
  let(:service) { SanitizingHotel::Supplier3.new }
  let(:fake_response) { '{}' }

  describe '#fetch_request' do
    let(:fake_response) { File.open('test/fixtures/files/supplier3/supplier3.json').read }

    before do
      parse_fake_response = JSON.parse(fake_response)
      expect(service).to receive(:fetch_request).and_return(parse_fake_response)
    end

    it 'should create 2 hotels with specified params' do
      expect(service).to receive(:update_hotel_amenities).exactly(2).times
      service.execute
      expect(Hotel.count).to eq(2)
      expect(Location.count).to eq(2)
    end

    it 'should create 2 room_images and 2 site_images' do
      service.execute

      expect(HotelImage.count).to eq(4)
      expect(HotelImage.room.count).to eq(2)
      expect(HotelImage.amenities.count).to eq(2)
    end
  end

  describe '#find_or_create_hotel!' do
    before do
      parse_fake_response = JSON.parse(fake_response)
      expect(service).to receive(:fetch_request).and_return(parse_fake_response)
    end
    context 'hotel params contain space at head and end lines' do
      let(:fake_response) { File.open('test/fixtures/files/supplier3/need_strip_hotel.json').read }
      it 'should sanitize data, strip' do
        service.execute
        hotel = Hotel.first
        expect(hotel.hotel_id[0]).not_to eq(' ')
        expect(hotel.name[0]).not_to eq(' ')
        expect(hotel.info[0]).not_to eq(' ')
        expect(hotel.hotel_id.last).not_to eq(' ')
        expect(hotel.info.last).not_to eq(' ')
        expect(hotel.name.last).not_to eq(' ')

        location = hotel.location
        expect(location.address[0]).not_to eq(' ')
        expect(location.address.last).not_to eq(' ')
      end
    end

    context 'hotel params contain nil values but name, hotel_id, address' do
      let(:fake_response) { File.open('test/fixtures/files/supplier3/need_ignore_nil.json').read }
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
    let(:amenity_params) { { "amenities" => ["Coffee machine"] } }

    it 'should call update_sanitized_amenities!' do
      expect(service).to receive(:update_sanitized_amenities!).with(anything, Amenity.categories[:general]).and_call_original

      service.send(:update_amenities!, amenity_params)
      expect(Amenity.count).to eq(1)
      expect(Amenity.general.first.name).to eq('coffee machine')
    end
  end
end
