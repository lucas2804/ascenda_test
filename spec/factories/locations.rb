FactoryBot.define do
  factory :location do
    lat { 1.5 }
    lng { 1.5 }
    address { "MyString" }
    city { "MyString" }
    country { "MyString" }
  end
end
