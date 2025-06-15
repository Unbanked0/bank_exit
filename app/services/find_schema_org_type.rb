class FindSchemaOrgType < ApplicationService
  attr_reader :category

  def initialize(category)
    @category = category
  end

  def call
    case category
    when 'restaurant' then 'Restaurant'
    when 'fast_food' then 'FastFoodRestaurant'
    when 'cafe', 'café', 'coffee' then 'CafeOrCoffeeShop'
    when 'bar', 'pub' then 'BarOrPub'
    when 'supermarket', 'grocery', 'convenience', 'farm' then 'FoodEstablishment'
    when 'pastry', 'bakery', 'confectionery' then 'Bakery'
    when 'florist' then 'Florist'
    when 'alcohol', 'wine', 'winery' then 'Winery'
    when 'veterinary' then 'AnimalShelter'
    when 'dentist' then 'Dentist'
    when 'doctor', 'optician', 'medical_supply' then 'MedicalBusiness'
    when 'laundry' then 'DryCleaningOrLaundry'
    when 'beauty' then 'HealthAndBeautyBusiness'
    when 'atm', 'bank', 'exchange', 'bureau_de_change', 'payment_terminal', 'money_transfer' then 'FinancialService'
    when 'hotel', 'guest_house', 'bed and breakfast', 'hostel', 'motel' then 'Hotel'
    when 'apartment', 'chalet' then 'Accommodation'
    when 'camp_site' then 'Campground'
    when 'toys', 'games', 'model' then 'ToyStore'
    when 'theme_park', 'attraction' then 'AmusementPark'
    when 'car_repair', 'car_parts' then 'AutoRepair'
    when 'car_rental' then 'AutoRental'
    when 'informatique', 'hardware', 'computer' then 'ComputerStore'
    when 'electrician', 'electrics', 'electronics_repair' then 'ElectronicsStore'
    when 'video_games' then 'VideoGame'
    when 'mobile_phone', 'telecommunication' then 'MobilePhoneStore'
    when 'books', 'library' then 'BookStore'
    when 'kindergarten', 'dancing_school' then 'School'
    when 'bicycle_repair_station' then 'BikeStore'
    when 'garden_centre' then 'Park'
    when 'clothes' then 'ClothingStore'
    when 'jewelry' then 'JewelryStore'
    when 'estate_agent' then 'RealEstateAgent'
    when 'financial_advisor' then 'FinancialService'
    when '10pin' then 'BowlingAlley'
    when 'fitness' then 'ExerciseGym'
    when 'plumber' then 'Plumber'
    when 'lawyer' then 'Attorney'
    when 'notary' then 'Notary'

    # From directory categories
    when 'alternative_media' then 'NewsMediaOrganization'
    when 'association' then 'Organization'
    else
      'LocalBusiness'
    end
  end
end
