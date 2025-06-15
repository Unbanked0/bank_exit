require 'rails_helper'

RSpec.describe MerchantIcon do
  subject { described_class.call(category) }

  describe '#call' do
    context 'when category is :restaurant' do
      let(:category) { 'restaurant' }

      it { is_expected.to eq 'restaurant' }
    end

    context 'when category is :fast_food' do
      let(:category) { 'fast_food' }

      it { is_expected.to eq 'fastfood' }
    end

    context 'when category is :cafe' do
      let(:category) { 'cafe' }

      it { is_expected.to eq 'local_cafe' }
    end

    context 'when category is :café' do
      let(:category) { 'café' }

      it { is_expected.to eq 'local_cafe' }
    end

    context 'when category is :coffee' do
      let(:category) { 'coffee' }

      it { is_expected.to eq 'local_cafe' }
    end

    context 'when category is :bar' do
      let(:category) { 'bar' }

      it { is_expected.to eq 'local_bar' }
    end

    context 'when category is :pub' do
      let(:category) { 'pub' }

      it { is_expected.to eq 'local_bar' }
    end

    context 'when category is :supermarket' do
      let(:category) { 'supermarket' }

      it { is_expected.to eq 'local_grocery_store' }
    end

    context 'when category is :grocery' do
      let(:category) { 'grocery' }

      it { is_expected.to eq 'local_grocery_store' }
    end

    context 'when category is :convenience' do
      let(:category) { 'convenience' }

      it { is_expected.to eq 'local_grocery_store' }
    end

    context 'when category is :farm' do
      let(:category) { 'farm' }

      it { is_expected.to eq 'local_grocery_store' }
    end

    context 'when category is :pastry' do
      let(:category) { 'pastry' }

      it { is_expected.to eq 'bakery_dining' }
    end

    context 'when category is :bakery' do
      let(:category) { 'bakery' }

      it { is_expected.to eq 'bakery_dining' }
    end

    context 'when category is :confectionery' do
      let(:category) { 'confectionery' }

      it { is_expected.to eq 'bakery_dining' }
    end

    context 'when category is :florist' do
      let(:category) { 'florist' }

      it { is_expected.to eq 'local_florist' }
    end

    context 'when category is :alcohol' do
      let(:category) { 'alcohol' }

      it { is_expected.to eq 'wine_bar' }
    end

    context 'when category is :wine' do
      let(:category) { 'wine' }

      it { is_expected.to eq 'wine_bar' }
    end

    context 'when category is :veterinary' do
      let(:category) { 'veterinary' }

      it { is_expected.to eq 'pets' }
    end

    context 'when category is :dentist' do
      let(:category) { 'dentist' }

      it { is_expected.to eq 'medical_services' }
    end

    context 'when category is :doctor' do
      let(:category) { 'doctor' }

      it { is_expected.to eq 'medical_services' }
    end

    context 'when category is :optician' do
      let(:category) { 'optician' }

      it { is_expected.to eq 'medical_services' }
    end

    context 'when category is :medical_supply' do
      let(:category) { 'medical_supply' }

      it { is_expected.to eq 'medical_services' }
    end

    context 'when category is :beauty' do
      let(:category) { 'beauty' }

      it { is_expected.to eq 'health_and_safety' }
    end

    context 'when category is :atm' do
      let(:category) { 'atm' }

      it { is_expected.to eq 'atm' }
    end

    context 'when category is :bank' do
      let(:category) { 'bank' }

      it { is_expected.to eq 'currency_exchange' }
    end

    context 'when category is :exchange' do
      let(:category) { 'exchange' }

      it { is_expected.to eq 'currency_exchange' }
    end

    context 'when category is :bureau_de_change' do
      let(:category) { 'bureau_de_change' }

      it { is_expected.to eq 'currency_exchange' }
    end

    context 'when category is :payment_terminal' do
      let(:category) { 'payment_terminal' }

      it { is_expected.to eq 'currency_exchange' }
    end

    context 'when category is :money_transfer' do
      let(:category) { 'money_transfer' }

      it { is_expected.to eq 'currency_exchange' }
    end

    context 'when category is :hotel' do
      let(:category) { 'hotel' }

      it { is_expected.to eq 'hotel' }
    end

    context 'when category is :guest_house' do
      let(:category) { 'guest_house' }

      it { is_expected.to eq 'hotel' }
    end

    context 'when category is :"bed and breakfast"' do
      let(:category) { 'bed and breakfast' }

      it { is_expected.to eq 'hotel' }
    end

    context 'when category is :hostel' do
      let(:category) { 'hostel' }

      it { is_expected.to eq 'hotel' }
    end

    context 'when category is :motel' do
      let(:category) { 'motel' }

      it { is_expected.to eq 'hotel' }
    end

    context 'when category is :apartment' do
      let(:category) { 'apartment' }

      it { is_expected.to eq 'apartment' }
    end

    context 'when category is :chalet' do
      let(:category) { 'chalet' }

      it { is_expected.to eq 'chalet' }
    end

    context 'when category is :camp_site' do
      let(:category) { 'camp_site' }

      it { is_expected.to eq 'camping' }
    end

    context 'when category is :toys' do
      let(:category) { 'toys' }

      it { is_expected.to eq 'toys' }
    end

    context 'when category is :games' do
      let(:category) { 'games' }

      it { is_expected.to eq 'games' }
    end

    context 'when category is :theme_park' do
      let(:category) { 'theme_park' }

      it { is_expected.to eq 'attractions' }
    end

    context 'when category is :attraction' do
      let(:category) { 'attraction' }

      it { is_expected.to eq 'attractions' }
    end

    context 'when category is :kindergarten' do
      let(:category) { 'kindergarten' }

      it { is_expected.to eq 'child_friendly' }
    end

    context 'when category is :car_repair' do
      let(:category) { 'car_repair' }

      it { is_expected.to eq 'car_repair' }
    end

    context 'when category is :car_parts' do
      let(:category) { 'car_parts' }

      it { is_expected.to eq 'car_repair' }
    end

    context 'when category is :car_rental' do
      let(:category) { 'car_rental' }

      it { is_expected.to eq 'directions_car' }
    end

    context 'when category is :informatique' do
      let(:category) { 'informatique' }

      it { is_expected.to eq 'computer' }
    end

    context 'when category is :hardware' do
      let(:category) { 'hardware' }

      it { is_expected.to eq 'computer' }
    end

    context 'when category is :computer' do
      let(:category) { 'computer' }

      it { is_expected.to eq 'computer' }
    end

    context 'when category is :video_games' do
      let(:category) { 'video_games' }

      it { is_expected.to eq 'gamepad' }
    end

    context 'when category is :mobile_phone' do
      let(:category) { 'mobile_phone' }

      it { is_expected.to eq 'local_phone' }
    end

    context 'when category is :telecommunication' do
      let(:category) { 'telecommunication' }

      it { is_expected.to eq 'local_phone' }
    end

    context 'when category is :camera' do
      let(:category) { 'camera' }

      it { is_expected.to eq 'camera' }
    end

    context 'when category is :photo' do
      let(:category) { 'photo' }

      it { is_expected.to eq 'photo' }
    end

    context 'when category is :books' do
      let(:category) { 'books' }

      it { is_expected.to eq 'library_books' }
    end

    context 'when category is :library' do
      let(:category) { 'library' }

      it { is_expected.to eq 'library_books' }
    end

    context 'when category is :dancing_school' do
      let(:category) { 'dancing_school' }

      it { is_expected.to eq 'school' }
    end

    context 'when category is :bag' do
      let(:category) { 'bag' }

      it { is_expected.to eq 'shopping_bag' }
    end

    context 'when category is :bicycle_repair_station' do
      let(:category) { 'bicycle_repair_station' }

      it { is_expected.to eq 'tire_repair' }
    end

    context 'when category is :laundry' do
      let(:category) { 'laundry' }

      it { is_expected.to eq 'local_laundry_service' }
    end

    context 'when category is :garden_centre' do
      let(:category) { 'garden_centre' }

      it { is_expected.to eq 'park' }
    end

    context 'when category is unknown' do
      let(:category) { 'foobar' }

      it { is_expected.to eq 'local_activity' }
    end
  end
end
