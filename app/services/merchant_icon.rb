class MerchantIcon < ApplicationService
  attr_reader :category

  def initialize(category)
    @category = category.to_s
  end

  def call
    case category
    when 'restaurant' then 'restaurant'
    when 'fast_food' then 'fastfood'
    when 'cafe', 'café', 'coffee' then 'local_cafe'
    when 'bar', 'pub' then 'local_bar'
    when 'supermarket', 'grocery', 'convenience', 'farm' then 'local_grocery_store'
    when 'pastry', 'bakery', 'confectionery' then 'bakery_dining'
    when 'florist' then 'local_florist'
    when 'alcohol', 'wine' then 'wine_bar'
    when 'veterinary' then 'pets'
    when 'dentist', 'doctor', 'optician', 'medical_supply' then 'medical_services'
    when 'beauty' then 'health_and_safety'
    when 'atm' then 'atm'
    when 'bank', 'exchange', 'bureau_de_change', 'payment_terminal', 'money_transfer' then 'currency_exchange'
    when 'hotel', 'guest_house', 'bed and breakfast', 'hostel', 'motel' then 'hotel'
    when 'apartment' then 'apartment'
    when 'chalet' then 'chalet'
    when 'camp_site' then 'camping'
    when 'toys' then 'toys'
    when 'games' then 'games'
    when 'theme_park', 'attraction' then 'attractions'
    when 'kindergarten' then 'child_friendly'
    when 'car_repair', 'car_parts' then 'car_repair'
    when 'car_rental' then 'directions_car'
    when 'informatique', 'hardware', 'computer' then 'computer'
    when 'video_games' then 'gamepad'
    when 'mobile_phone', 'telecommunication' then 'local_phone'
    when 'camera' then 'camera'
    when 'photo' then 'photo'
    when 'books', 'library' then 'library_books'
    when 'dancing_school' then 'school'
    when 'bag' then 'shopping_bag'
    when 'bicycle_repair_station' then 'tire_repair'
    when 'laundry' then 'local_laundry_service'
    when 'garden_centre' then 'park'
    else
      'local_activity'
    end
  end
end
