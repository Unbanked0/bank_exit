require 'rails_helper'

RSpec.describe MerchantDecorator do
  let(:decorator) { merchant.decorate }

  describe '#address_lines' do
    subject { decorator.address_lines(**options) }

    let(:options) { {} }

    let(:merchant) do
      build(
        :merchant,
        house_number: '12',
        street: 'Rue Exemple',
        postcode: '75000',
        city: 'Paris',
        country: 'fr'
      )
    end

    context 'with default options' do
      it { is_expected.to eq(['12 Rue Exemple', '75000 Paris', '🇫🇷 France']) }
    end

    context 'with multiline disabled' do
      let(:options) { { multiline: false } }

      it { is_expected.to eq(['12 Rue Exemple 75000 Paris', '🇫🇷 France']) }
    end

    context 'without country' do
      let(:options) { { show_country: false } }

      it { is_expected.to eq(['12 Rue Exemple', '75000 Paris']) }
    end

    context 'with multiline disabled and without country' do
      let(:options) do
        {
          multiline: false,
          show_country: false
        }
      end

      it { is_expected.to eq(['12 Rue Exemple 75000 Paris']) }
    end

    context 'with incomplete address data' do
      let(:merchant) do
        build(
          :merchant,
          house_number: nil,
          street: 'Rue Exemple',
          postcode: nil,
          city: 'Paris',
          country: 'fr'
        )
      end

      it { is_expected.to eq(['Rue Exemple', 'Paris', '🇫🇷 France']) }
    end

    context 'with only country data' do
      let(:merchant) do
        build(
          :merchant,
          house_number: nil,
          street: nil,
          postcode: nil,
          city: nil,
          country: 'fr'
        )
      end

      it { is_expected.to eq(['🇫🇷 France']) }
    end
  end

  describe '#formatted_country' do
    let(:merchant) do
      build(
        :merchant,
        house_number: '12',
        street: 'Rue Exemple',
        postcode: '75000',
        city: 'Paris',
        country: 'fr'
      )
    end

    context 'with default options' do
      subject { decorator.formatted_country }

      it { is_expected.to eq('🇫🇷 France') }
    end

    context 'when label is disabled' do
      subject { decorator.formatted_country(show_label: false) }

      it { is_expected.to eq('🇫🇷') }
    end

    context 'when flag is disabled' do
      subject { decorator.formatted_country(show_flag: false) }

      it { is_expected.to eq('France') }
    end
  end

  describe '#might_be_outdated?' do
    subject { decorator.might_be_outdated? }

    let(:merchant) { create :merchant, last_survey_on: last_survey_on }

    context 'when #last_survey_on is not defined' do
      let(:last_survey_on) { nil }

      it { is_expected.to be false }
    end

    context 'when #last_survey_on is less than 3 years ago' do
      let(:last_survey_on) { 1.year.ago }

      it { is_expected.to be false }
    end

    context 'when #last_survey_on is more than 3 years ago' do
      let(:last_survey_on) { 5.years.ago }

      it { is_expected.to be true }
    end
  end

  describe '#outdated_level' do
    subject { decorator.outdated_level }

    let(:merchant) { create :merchant, last_survey_on: last_survey_on }

    context 'when #last_survey_on is not defined' do
      let(:last_survey_on) { nil }

      it { is_expected.to eq :unknown }
    end

    context 'when #last_survey_on is between 0 and 2 years ago' do
      let(:last_survey_on) { 1.year.ago }

      it { is_expected.to eq :soft }
    end

    context 'when #last_survey_on is between 2 and 3 years ago' do
      let(:last_survey_on) { 30.months.ago }

      it { is_expected.to eq :medium }
    end

    context 'when #last_survey_on is more than 3 years ago' do
      let(:last_survey_on) { 5.years.ago }

      it { is_expected.to eq :hard }
    end
  end
end
