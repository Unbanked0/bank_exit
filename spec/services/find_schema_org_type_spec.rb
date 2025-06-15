require 'rails_helper'

RSpec.describe FindSchemaOrgType do
  subject { described_class.call(category) }

  describe '#call' do
    context 'when category is :restaurant' do
      let(:category) { 'restaurant' }

      it { is_expected.to eq 'Restaurant' }
    end

    context 'when category is :fast_food' do
      let(:category) { 'fast_food' }

      it { is_expected.to eq 'FastFoodRestaurant' }
    end

    context 'when category is :cafe' do
      let(:category) { 'cafe' }

      it { is_expected.to eq 'CafeOrCoffeeShop' }
    end

    context 'when category is :café' do
      let(:category) { 'café' }

      it { is_expected.to eq 'CafeOrCoffeeShop' }
    end

    context 'when category is :coffee' do
      let(:category) { 'coffee' }

      it { is_expected.to eq 'CafeOrCoffeeShop' }
    end

    context 'when category is :bar' do
      let(:category) { 'bar' }

      it { is_expected.to eq 'BarOrPub' }
    end

    context 'when category is :pub' do
      let(:category) { 'pub' }

      it { is_expected.to eq 'BarOrPub' }
    end

    context 'when category is :supermarket' do
      let(:category) { 'supermarket' }

      it { is_expected.to eq 'FoodEstablishment' }
    end

    context 'when category is :grocery' do
      let(:category) { 'grocery' }

      it { is_expected.to eq 'FoodEstablishment' }
    end

    context 'when category is :convenience' do
      let(:category) { 'convenience' }

      it { is_expected.to eq 'FoodEstablishment' }
    end

    context 'when category is :farm' do
      let(:category) { 'farm' }

      it { is_expected.to eq 'FoodEstablishment' }
    end

    context 'when category is :pastry' do
      let(:category) { 'pastry' }

      it { is_expected.to eq 'Bakery' }
    end

    context 'when category is :bakery' do
      let(:category) { 'bakery' }

      it { is_expected.to eq 'Bakery' }
    end

    context 'when category is :confectionery' do
      let(:category) { 'confectionery' }

      it { is_expected.to eq 'Bakery' }
    end

    context 'when category is :florist' do
      let(:category) { 'florist' }

      it { is_expected.to eq 'Florist' }
    end

    context 'when category is :alcohol' do
      let(:category) { 'alcohol' }

      it { is_expected.to eq 'Winery' }
    end

    context 'when category is :wine' do
      let(:category) { 'wine' }

      it { is_expected.to eq 'Winery' }
    end

    context 'when category is :veterinary' do
      let(:category) { 'veterinary' }

      it { is_expected.to eq 'AnimalShelter' }
    end

    context 'when category is :dentist' do
      let(:category) { 'dentist' }

      it { is_expected.to eq 'Dentist' }
    end

    context 'when category is :doctor' do
      let(:category) { 'doctor' }

      it { is_expected.to eq 'MedicalBusiness' }
    end

    context 'when category is :optician' do
      let(:category) { 'optician' }

      it { is_expected.to eq 'MedicalBusiness' }
    end

    context 'when category is :medical_supply' do
      let(:category) { 'medical_supply' }

      it { is_expected.to eq 'MedicalBusiness' }
    end

    context 'when category is :"laundry"' do
      let(:category) { 'laundry' }

      it { is_expected.to eq 'DryCleaningOrLaundry' }
    end

    context 'when category is :beauty' do
      let(:category) { 'beauty' }

      it { is_expected.to eq 'HealthAndBeautyBusiness' }
    end

    context 'when category is :atm' do
      let(:category) { 'atm' }

      it { is_expected.to eq 'FinancialService' }
    end

    context 'when category is :bank' do
      let(:category) { 'bank' }

      it { is_expected.to eq 'FinancialService' }
    end

    context 'when category is :exchange' do
      let(:category) { 'exchange' }

      it { is_expected.to eq 'FinancialService' }
    end

    context 'when category is :bureau_de_change' do
      let(:category) { 'bureau_de_change' }

      it { is_expected.to eq 'FinancialService' }
    end

    context 'when category is :payment_terminal' do
      let(:category) { 'payment_terminal' }

      it { is_expected.to eq 'FinancialService' }
    end

    context 'when category is :money_transfer' do
      let(:category) { 'money_transfer' }

      it { is_expected.to eq 'FinancialService' }
    end

    context 'when category is :hotel' do
      let(:category) { 'hotel' }

      it { is_expected.to eq 'Hotel' }
    end

    context 'when category is :guest_house' do
      let(:category) { 'guest_house' }

      it { is_expected.to eq 'Hotel' }
    end

    context 'when category is :"bed and breakfast"' do
      let(:category) { 'bed and breakfast' }

      it { is_expected.to eq 'Hotel' }
    end

    context 'when category is :hostel' do
      let(:category) { 'hostel' }

      it { is_expected.to eq 'Hotel' }
    end

    context 'when category is :motel' do
      let(:category) { 'motel' }

      it { is_expected.to eq 'Hotel' }
    end

    context 'when category is :apartment' do
      let(:category) { 'apartment' }

      it { is_expected.to eq 'Accommodation' }
    end

    context 'when category is :chalet' do
      let(:category) { 'chalet' }

      it { is_expected.to eq 'Accommodation' }
    end

    context 'when category is :camp_site' do
      let(:category) { 'camp_site' }

      it { is_expected.to eq 'Campground' }
    end

    context 'when category is :toys' do
      let(:category) { 'toys' }

      it { is_expected.to eq 'ToyStore' }
    end

    context 'when category is :games' do
      let(:category) { 'games' }

      it { is_expected.to eq 'ToyStore' }
    end

    context 'when category is :model' do
      let(:category) { 'model' }

      it { is_expected.to eq 'ToyStore' }
    end

    context 'when category is :theme_park' do
      let(:category) { 'theme_park' }

      it { is_expected.to eq 'AmusementPark' }
    end

    context 'when category is :attraction' do
      let(:category) { 'attraction' }

      it { is_expected.to eq 'AmusementPark' }
    end

    context 'when category is :car_repair' do
      let(:category) { 'car_repair' }

      it { is_expected.to eq 'AutoRepair' }
    end

    context 'when category is :car_parts' do
      let(:category) { 'car_parts' }

      it { is_expected.to eq 'AutoRepair' }
    end

    context 'when category is :car_rental' do
      let(:category) { 'car_rental' }

      it { is_expected.to eq 'AutoRental' }
    end

    context 'when category is :informatique' do
      let(:category) { 'informatique' }

      it { is_expected.to eq 'ComputerStore' }
    end

    context 'when category is :hardware' do
      let(:category) { 'hardware' }

      it { is_expected.to eq 'ComputerStore' }
    end

    context 'when category is :computer' do
      let(:category) { 'computer' }

      it { is_expected.to eq 'ComputerStore' }
    end

    context 'when category is :electrician' do
      let(:category) { 'electrician' }

      it { is_expected.to eq 'ElectronicsStore' }
    end

    context 'when category is :electronics_repair' do
      let(:category) { 'electronics_repair' }

      it { is_expected.to eq 'ElectronicsStore' }
    end

    context 'when category is :electrics' do
      let(:category) { 'electrics' }

      it { is_expected.to eq 'ElectronicsStore' }
    end

    context 'when category is :video_games' do
      let(:category) { 'video_games' }

      it { is_expected.to eq 'VideoGame' }
    end

    context 'when category is :mobile_phone' do
      let(:category) { 'mobile_phone' }

      it { is_expected.to eq 'MobilePhoneStore' }
    end

    context 'when category is :telecommunication' do
      let(:category) { 'telecommunication' }

      it { is_expected.to eq 'MobilePhoneStore' }
    end

    context 'when category is :camera' do
      let(:category) { 'camera' }

      it { is_expected.to eq 'LocalBusiness' }
    end

    context 'when category is :photo' do
      let(:category) { 'photo' }

      it { is_expected.to eq 'LocalBusiness' }
    end

    context 'when category is :books' do
      let(:category) { 'books' }

      it { is_expected.to eq 'BookStore' }
    end

    context 'when category is :library' do
      let(:category) { 'library' }

      it { is_expected.to eq 'BookStore' }
    end

    context 'when category is :kindergarten' do
      let(:category) { 'kindergarten' }

      it { is_expected.to eq 'School' }
    end

    context 'when category is :dancing_school' do
      let(:category) { 'dancing_school' }

      it { is_expected.to eq 'School' }
    end

    context 'when category is :bag' do
      let(:category) { 'bag' }

      it { is_expected.to eq 'LocalBusiness' }
    end

    context 'when category is :bicycle_repair_station' do
      let(:category) { 'bicycle_repair_station' }

      it { is_expected.to eq 'BikeStore' }
    end

    context 'when category is :garden_centre' do
      let(:category) { 'garden_centre' }

      it { is_expected.to eq 'Park' }
    end

    context 'when category is :clothes' do
      let(:category) { 'clothes' }

      it { is_expected.to eq 'ClothingStore' }
    end

    context 'when category is :jewelry' do
      let(:category) { 'jewelry' }

      it { is_expected.to eq 'JewelryStore' }
    end

    context 'when category is :estate_agent' do
      let(:category) { 'estate_agent' }

      it { is_expected.to eq 'RealEstateAgent' }
    end

    context 'when category is :financial_advisor' do
      let(:category) { 'financial_advisor' }

      it { is_expected.to eq 'FinancialService' }
    end

    context 'when category is :10pin' do
      let(:category) { '10pin' }

      it { is_expected.to eq 'BowlingAlley' }
    end

    context 'when category is :fitness' do
      let(:category) { 'fitness' }

      it { is_expected.to eq 'ExerciseGym' }
    end

    context 'when category is :plumber' do
      let(:category) { 'plumber' }

      it { is_expected.to eq 'Plumber' }
    end

    context 'when category is :lawyer' do
      let(:category) { 'lawyer' }

      it { is_expected.to eq 'Attorney' }
    end

    context 'when category is :notary' do
      let(:category) { 'notary' }

      it { is_expected.to eq 'Notary' }
    end

    context 'when category is :alternative_media' do
      let(:category) { 'alternative_media' }

      it { is_expected.to eq 'NewsMediaOrganization' }
    end

    context 'when category is :association' do
      let(:category) { 'association' }

      it { is_expected.to eq 'Organization' }
    end

    context 'when category is unknown' do
      let(:category) { 'foobar' }

      it { is_expected.to eq 'LocalBusiness' }
    end
  end
end
