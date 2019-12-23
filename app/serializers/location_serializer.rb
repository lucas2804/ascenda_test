class LocationSerializer < ActiveModel::Serializer
  attributes :lat, :lng, :address, :city, :country
end
