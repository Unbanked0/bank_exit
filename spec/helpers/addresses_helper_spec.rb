require 'rails_helper'

RSpec.describe AddressesHelper do
  describe '#formatted_address' do
    subject { helper.formatted_address(address) }

    let(:address) do
      [
        '12 Rue Exemple',
        '75000 Paris',
        '🇫🇷 France'
      ]
    end

    it { is_expected.to eq('12 Rue Exemple<br>75000 Paris<br>🇫🇷 France') }

    context 'with empty lines' do
      let(:address) do
        [
          '12 Rue Exemple',
          '🇫🇷 France'
        ]
      end

      it { is_expected.to eq('12 Rue Exemple<br>🇫🇷 France') }
    end
  end

  describe '#formatted_country' do
    subject { helper.formatted_country(country, **options) }

    let(:country) { 'fr' }
    let(:options) { {} }

    context 'with default options' do
      it { is_expected.to eq('🇫🇷 France') }
    end

    context 'with flag disabled' do
      let(:options) { { show_flag: false } }

      it { is_expected.to eq('France') }
    end

    context 'with label disabled' do
      let(:options) { { show_label: false } }

      it { is_expected.to eq('🇫🇷') }
    end

    context 'with flag and label disabled' do
      let(:options) do
        {
          show_flag: false,
          show_label: false
        }
      end

      it { is_expected.to eq('France') }
    end
  end
end
