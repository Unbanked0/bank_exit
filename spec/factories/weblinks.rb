FactoryBot.define do
  factory :weblink do
    url { Faker::Internet.url(host: 'example.com') }
  end
end
