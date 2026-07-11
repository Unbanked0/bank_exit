FactoryBot.define do
  factory :ecosystem_item do
    TEST_LOCALES.each do |locale|
      send("name_#{locale}") { "Name #{locale}" }
      send("description_#{locale}") { "Description #{locale}" }
    end

    enabled { true }
  end
end
