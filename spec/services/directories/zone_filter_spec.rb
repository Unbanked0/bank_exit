require 'rails_helper'

RSpec.describe Directories::ZoneFilter do
  let(:relation) { Directory.enabled }

  let(:delivery_world) { create :delivery_zone, :world }
  let(:delivery_continent_as) { create :delivery_zone, mode: :continent, value: 'AS' }
  let(:delivery_country_fr) { create :delivery_zone, mode: :country, value: 'FR' }
  let(:delivery_region_idf) { create :delivery_zone, mode: :region, value: 'FR-IDF' }
  let(:delivery_department_75) { create :delivery_zone, mode: :department, value: 'FR-75' }
  let(:delivery_city_paris) { create :delivery_zone, mode: :city, value: 'Paris' }
  let(:delivery_region_md) { create :delivery_zone, mode: :region, value: 'ES-MD' }
  let(:delivery_department_m) { create :delivery_zone, mode: :department, value: 'ES-M' }
  let(:delivery_city_madrid) { create :delivery_zone, mode: :city, value: 'Madrid' }
  let(:delivery_city_tokyo) { create :delivery_zone, mode: :city, value: 'Tokyo' }

  before do
    stub_geocoder_from_fixture!

    create :directory # no delivery zone

    delivery_world

    delivery_country_fr
    delivery_region_idf
    delivery_department_75
    delivery_city_paris

    delivery_region_md
    delivery_department_m
    delivery_city_madrid

    delivery_continent_as
    delivery_city_tokyo
  end

  describe '#call' do
    subject(:call) { described_class.call(relation, **params) }

    context 'when filtering by world' do
      let(:params) { { world: '1' } }

      it { is_expected.to contain_exactly(delivery_world.deliverable) }
    end

    context 'when filtering by continent' do
      let(:params) { { continent: 'AS' } }

      it { is_expected.to contain_exactly(delivery_world.deliverable, delivery_continent_as.deliverable) }
    end

    context 'when filtering by country' do
      let(:params) { { country: 'FR' } }

      it { is_expected.to contain_exactly(delivery_world.deliverable, delivery_country_fr.deliverable) }
    end

    context 'when filtering by region' do
      let(:params) { { region: 'FR-IDF' } }

      it { is_expected.to contain_exactly(delivery_world.deliverable, delivery_country_fr.deliverable, delivery_region_idf.deliverable) }
    end

    context 'when filtering by department' do
      let(:params) { { department: 'FR-75' } }

      it { is_expected.to contain_exactly(delivery_world.deliverable, delivery_country_fr.deliverable, delivery_region_idf.deliverable, delivery_department_75.deliverable) }
    end

    context 'when filtering by city' do
      context 'when city is Paris' do
        let(:params) { { city: 'Paris' } }

        it { is_expected.to contain_exactly(delivery_world.deliverable, delivery_country_fr.deliverable, delivery_region_idf.deliverable, delivery_department_75.deliverable, delivery_city_paris.deliverable) }
      end

      context 'when city is Tokyo' do
        let(:params) { { city: 'Tokyo' } }

        it { is_expected.to contain_exactly(delivery_world.deliverable, delivery_continent_as.deliverable, delivery_city_tokyo.deliverable) }
      end
    end
  end
end
