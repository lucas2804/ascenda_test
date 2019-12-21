require 'rails_helper'

RSpec.describe SanitizingHotel::Supplier1 do
  describe '#fetch_request' do
    let(:fake_response) { File.open('test/fixtures/files/supplier1.json').read }
    let(:service) { SanitizingHotel::Supplier1.new.execute }

    it 'should create 2 hotels with specified params' do
      service
      expect(Hotel.count).to eq(2)
    end

    it 'should sanitize data, strip and downcase value' do

    end

    it 'should ready to check nil all params' do

    end
  end
end
