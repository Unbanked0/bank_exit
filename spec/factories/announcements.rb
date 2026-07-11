FactoryBot.define do
  factory :announcement do
    TEST_LOCALES.each do |locale|
      send("title_#{locale}") { "Title #{locale}" }
      send("description_#{locale}") { "Description #{locale}" }
    end

    enabled { true }

    traits_for_enum :mode
  end
end
