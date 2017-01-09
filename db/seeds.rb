User.destroy_all
5.times do
  User.create(
    username: Faker::Internet.user_name,
    email: Faker::Internet.email,
    password: 'weakpass1'
  )
end

demo_user = User.create!(
  username: 'DemoUser',
  email: 'demo@fake.com',
  password: 'demouser'
)

100.times do
  Contact.create!(
    email: Faker::Internet.email,
    name: Faker::Name.name,
    phone: Faker::PhoneNumber.cell_phone,
    address: "#{Faker::Address.street_address} #{Faker::Address.city} #{Faker::Address.zip_code}",
    birthdate: Faker::Date.between(60.years.ago, 18.years.ago),
    organization: Faker::Company.name,
    user: demo_user
  )
end
