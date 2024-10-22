FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    full_name { Faker::Name.name }
    password { 'password' }
    username { Faker::Internet.unique.username }
  end
end
