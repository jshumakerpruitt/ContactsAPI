FactoryGirl.define do
  factory :contact do
    email Faker::Internet.email
    name Faker::Name.name
    phone Faker::PhoneNumber.cell_phone
    address "#{Faker::Address.street_address} #{Faker::Address.city} #{Faker::Address.zip_code}"
    birthdat Faker::Date.between(60.years.ago, 18.years.ago)
    user nil
  end
end
