require 'rails_helper'

RSpec.describe SanitizingHotel::Supplier1 do
  let(:service) { SanitizingHotel::Supplier1.new.execute }

  describe '#fetch_request' do
    let(:fake_response) { File.open('test/fixtures/files/supplier1.json').read }

    it 'should create 3 hotels with specified params' do
      service
      expect(Hotel.count).to eq(3)
    end
  end

  describe '#find_or_create_hotel!' do
    let(:fake_response) { File.open('test/fixtures/files/supplier1/need_strip_hotel.json').read }

    context 'hotel params contain space at head and end lines' do
      it 'should sanitize data, strip' do
        service
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
        service
        expect(Hotel.count).to eq(1)
      end
    end
  end
end
