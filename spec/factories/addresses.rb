FactoryBot.define do
  factory :address do
    latitude  { 48.8566 } # Paris latitude
    longitude { 2.3522 } # Paris longitude
    sequence(:label) { 'Paris' }

    association :addressable, factory: :directory
  end
end
