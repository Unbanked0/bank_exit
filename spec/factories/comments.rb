FactoryBot.define do
  factory :comment do
    content { 'Foobar comment' }
    rating { 4 }
    language { 'en' }
    affidavit { '1' }

    commentable factory: :merchant

    trait :flagged do
      flag_reason { :spam }
    end
  end
end
