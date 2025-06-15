require 'rails_helper'

RSpec.describe ExtractCategory do
  subject { described_class.call(properties) }

  describe '#call' do
    let(:properties) do
      {
        'healthcare:speciality': 'healthcare:speciality',
        healthcare: 'healthcare',
        amenity: 'amenity',
        amenity_1: 'amenity_1',
        amenity_2: 'amenity_2',
        craft: 'craft',
        office: 'office',
        sport: 'sport',
        shop: 'shop',
        tourism: 'tourism',
        leisure: 'leisure'
      }.as_json
    end

    context 'when [healthcare:speciality] is present' do
      it { is_expected.to eq 'healthcare:speciality' }
    end

    context 'when [healthcare] is present' do
      before { properties.delete('healthcare:speciality') }

      it { is_expected.to eq 'healthcare' }
    end

    context 'when [amenity] is present' do
      before do
        properties.delete('healthcare:speciality')
        properties.delete('healthcare')
      end

      it { is_expected.to eq 'amenity' }
    end

    context 'when [amenity_1] is present' do
      before do
        properties.delete('healthcare:speciality')
        properties.delete('healthcare')
        properties.delete('amenity')
      end

      it { is_expected.to eq 'amenity_1' }
    end

    context 'when [amenity_2] is present' do
      before do
        properties.delete('healthcare:speciality')
        properties.delete('healthcare')
        properties.delete('amenity')
        properties.delete('amenity_1')
      end

      it { is_expected.to eq 'amenity_2' }
    end

    context 'when [craft] is present' do
      before do
        properties.delete('healthcare:speciality')
        properties.delete('healthcare')
        properties.delete('amenity')
        properties.delete('amenity_1')
        properties.delete('amenity_2')
      end

      it { is_expected.to eq 'craft' }
    end

    context 'when [office] is present' do
      before do
        properties.delete('healthcare:speciality')
        properties.delete('healthcare')
        properties.delete('amenity')
        properties.delete('amenity_1')
        properties.delete('amenity_2')
        properties.delete('craft')
      end

      it { is_expected.to eq 'office' }
    end

    context 'when [sport] is present' do
      before do
        properties.delete('healthcare:speciality')
        properties.delete('healthcare')
        properties.delete('amenity')
        properties.delete('amenity_1')
        properties.delete('amenity_2')
        properties.delete('craft')
        properties.delete('office')
      end

      it { is_expected.to eq 'sport' }
    end

    context 'when [shop] is present' do
      before do
        properties.delete('healthcare:speciality')
        properties.delete('healthcare')
        properties.delete('amenity')
        properties.delete('amenity_1')
        properties.delete('amenity_2')
        properties.delete('craft')
        properties.delete('office')
        properties.delete('sport')
      end

      it { is_expected.to eq 'shop' }
    end

    context 'when [tourism] is present' do
      before do
        properties.delete('healthcare:speciality')
        properties.delete('healthcare')
        properties.delete('amenity')
        properties.delete('amenity_1')
        properties.delete('amenity_2')
        properties.delete('craft')
        properties.delete('office')
        properties.delete('sport')
        properties.delete('shop')
      end

      it { is_expected.to eq 'tourism' }
    end

    context 'when [leisure] is present' do
      before do
        properties.delete('healthcare:speciality')
        properties.delete('healthcare')
        properties.delete('amenity')
        properties.delete('amenity_1')
        properties.delete('amenity_2')
        properties.delete('craft')
        properties.delete('office')
        properties.delete('sport')
        properties.delete('shop')
        properties.delete('tourism')
      end

      it { is_expected.to eq 'leisure' }
    end
  end

  context 'when category is not foundable' do
    let(:properties) { {} }

    it { is_expected.to be_nil }
  end

  context 'when category is multi ; separated' do
    let(:properties) { { amenity: 'foo;bar;baz' }.as_json }

    it { is_expected.to eq 'foo' }
  end

  context 'when category is :doctors' do
    let(:properties) { { amenity: 'doctors' }.as_json }

    it { is_expected.to eq 'doctor' }
  end

  context 'when category is :general' do
    let(:properties) { { amenity: 'general' }.as_json }

    it { is_expected.to eq 'doctor' }
  end

  context 'when category is :convenience' do
    let(:properties) { { amenity: 'convenience' }.as_json }

    it { is_expected.to eq 'grocery' }
  end

  context 'when category is :coffee' do
    let(:properties) { { amenity: 'coffee' }.as_json }

    it { is_expected.to eq 'cafe' }
  end

  context 'when category is :bureau_de_change' do
    let(:properties) { { amenity: 'bureau_de_change' }.as_json }

    it { is_expected.to eq 'exchange' }
  end

  context 'when category is :hostel' do
    let(:properties) { { amenity: 'hostel' }.as_json }

    it { is_expected.to eq 'hotel' }
  end

  context 'when category is :attraction' do
    let(:properties) { { amenity: 'attraction' }.as_json }

    it { is_expected.to eq 'theme_park' }
  end

  context 'when category is :magnétiseur' do
    let(:properties) { { amenity: 'magnétiseur' }.as_json }

    it { is_expected.to eq 'magnetizer' }
  end

  context 'when category is :informatique' do
    let(:properties) { { amenity: 'informatique' }.as_json }

    it { is_expected.to eq 'it' }
  end

  context 'when category is :jeweller' do
    let(:properties) { { amenity: 'jeweller' }.as_json }

    it { is_expected.to eq 'jewelry' }
  end

  context 'when category is :soccer' do
    let(:properties) { { amenity: 'soccer' }.as_json }

    it { is_expected.to eq 'football' }
  end

  context 'when category is :surfing' do
    let(:properties) { { amenity: 'surfing' }.as_json }

    it { is_expected.to eq 'surf' }
  end

  context 'when category is :kitesurfing' do
    let(:properties) { { amenity: 'kitesurfing' }.as_json }

    it { is_expected.to eq 'surf' }
  end

  context 'when category is :dentista' do
    let(:properties) { { amenity: 'dentista' }.as_json }

    it { is_expected.to eq 'dentist' }
  end

  context 'when category is :paediatric_dentistry' do
    let(:properties) { { amenity: 'paediatric_dentistry' }.as_json }

    it { is_expected.to eq 'dentist' }
  end

  context 'when category is :professional_tooth_cleaning' do
    let(:properties) { { amenity: 'professional_tooth_cleaning' }.as_json }

    it { is_expected.to eq 'dentist' }
  end

  context 'when category is :musical_instrument' do
    let(:properties) { { amenity: 'musical_instrument' }.as_json }

    it { is_expected.to eq 'music' }
  end

  context 'when category is :travel_agent' do
    let(:properties) { { amenity: 'travel_agent' }.as_json }

    it { is_expected.to eq 'travel_agency' }
  end

  context 'when category is :coworking' do
    let(:properties) { { amenity: 'coworking' }.as_json }

    it { is_expected.to eq 'coworking_space' }
  end

  context 'when category is :10pin' do
    let(:properties) { { amenity: '10pin' }.as_json }

    it { is_expected.to eq 'bowling' }
  end

  context 'when category is :educational_institution' do
    let(:properties) { { amenity: 'educational_institution' }.as_json }

    it { is_expected.to eq 'school' }
  end

  context 'when category is :online_shop' do
    let(:properties) { { amenity: 'online_shop' }.as_json }

    it { is_expected.to eq 'online_store' }
  end

  context 'when category is :onlineshop' do
    let(:properties) { { amenity: 'onlineshop' }.as_json }

    it { is_expected.to eq 'online_store' }
  end

  context 'when category is :marketplace' do
    let(:properties) { { amenity: 'marketplace' }.as_json }

    it { is_expected.to eq 'online_store' }
  end

  context 'when category is :liquid laundry detergent' do
    let(:properties) { { amenity: 'liquid laundry detergent' }.as_json }

    it { is_expected.to eq 'laundry' }
  end

  context 'when category is :physiotherapie_praxis' do
    let(:properties) { { amenity: 'physiotherapie_praxis' }.as_json }

    it { is_expected.to eq 'physiotherapy' }
  end

  context 'when category is :reparaciónes de moviles y tablet' do
    let(:properties) { { amenity: 'reparaciónes de moviles y tablet' }.as_json }

    it { is_expected.to eq 'mobile_phone' }
  end

  context 'when category is :papeleria' do
    let(:properties) { { amenity: 'papeleria' }.as_json }

    it { is_expected.to eq 'stationery' }
  end

  context 'when category is :smoking' do
    let(:properties) { { amenity: 'smoking' }.as_json }

    it { is_expected.to eq 'tobacco' }
  end

  context 'when category is :interior_design' do
    let(:properties) { { amenity: 'interior_design' }.as_json }

    it { is_expected.to eq 'interior_decoration' }
  end

  context 'when category is :graphic_design' do
    let(:properties) { { amenity: 'graphic_design' }.as_json }

    it { is_expected.to eq 'web_design' }
  end

  context 'when category is :flash_frozen_healthy_food' do
    let(:properties) { { amenity: 'flash_frozen_healthy_food' }.as_json }

    it { is_expected.to eq 'frozen_food' }
  end

  context 'when category is :financial' do
    let(:properties) { { amenity: 'financial' }.as_json }

    it { is_expected.to eq 'financial_advisor' }
  end

  context 'when category is :engineering' do
    let(:properties) { { amenity: 'engineering' }.as_json }

    it { is_expected.to eq 'engineer' }
  end

  context 'when category is :stickerei' do
    let(:properties) { { amenity: 'stickerei' }.as_json }

    it { is_expected.to eq 'embroiderer' }
  end

  context 'when category is :cosmetic_skincare' do
    let(:properties) { { amenity: 'cosmetic_skincare' }.as_json }

    it { is_expected.to eq 'cosmetic' }
  end

  context 'when category is :paint' do
    let(:properties) { { amenity: 'paint' }.as_json }

    it { is_expected.to eq 'painter' }
  end
end
