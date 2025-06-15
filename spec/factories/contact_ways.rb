FactoryBot.define do
  factory :contact_way do
    value { 'foobar' }

    association :contactable, factory: :directory

    traits_for_enum :role
  end
end
