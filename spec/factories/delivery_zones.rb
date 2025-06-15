FactoryBot.define do
  factory :delivery_zone do
    association :deliverable, factory: :directory

    trait :department_75 do
      mode { :department }
      value { 'Paris' }
      department_code { 'FR-75' }
      region_code { 'FR-IDF' }
      continent_code { 'EU' }
    end

    trait :department_77 do
      mode { :department }
      value { 'Jossigny' }
      department_code { 'FR-77' }
      region_code { 'FR-IDF' }
      continent_code { 'EU' }
    end

    trait :country_japan do
      mode { :country }
      value { 'JP' }
      country_code { 'JP' }
      continent_code { 'AS' }
    end

    trait :world do
      mode { :world }
      value { '' }
      country_code { nil }
    end
  end
end
