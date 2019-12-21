FactoryBot.define do
  factory :amenity do
    name { |n| "business #{n}" }
  end
end
