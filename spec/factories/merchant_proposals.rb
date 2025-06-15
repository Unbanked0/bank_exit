FactoryBot.define do
  factory :merchant_proposal do
    sequence(:name) { |n| "Merchant ##{n}" }
    category { 'bakery' }
    coins { %w[bitcoin monero] }

    with_address

    trait :with_address do
      street { 'Foo' }
      postcode { 'Bar' }
      city { 'MyCity' }
      country { 'MyCountry' }
    end
  end
end
