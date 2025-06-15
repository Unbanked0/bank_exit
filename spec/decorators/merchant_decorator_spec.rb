require 'rails_helper'

RSpec.describe MerchantDecorator do
  let(:merchant) do
    create :merchant,
           house_number: 3, street: 'Square Street',
           postcode: 'ABC123', city: 'MyCity',
           country: 'FR'
  end
  let(:decorator) { merchant.decorate }

  describe '#full_address_with_country' do
    subject do
      decorator.full_address_with_country(
        show_flag: show_flag, expanded: expanded
      )
    end

    context 'when show_flag is true' do
      let(:show_flag) { true }

      context 'when expanded is true' do
        let(:expanded) { true }

        it { is_expected.to eq '3 Square Street<br />ABC123 MyCity<br />🇫🇷 France' }

        context 'when only country is present' do
          before do
            merchant.house_number = ''
            merchant.street = ''
            merchant.postcode = ''
            merchant.city = ''
          end

          it { is_expected.to eq '🇫🇷 France' }
        end
      end

      context 'when expanded is false' do
        let(:expanded) { false }

        it { is_expected.to eq '3 Square Street ABC123 MyCity<br />🇫🇷 France' }

        context 'when only country is present' do
          before do
            merchant.house_number = ''
            merchant.street = ''
            merchant.postcode = ''
            merchant.city = ''
          end

          it { is_expected.to eq '🇫🇷 France' }
        end
      end
    end

    context 'when show_flag is false' do
      let(:show_flag) { false }

      context 'when expanded is true' do
        let(:expanded) { true }

        it { is_expected.to eq '3 Square Street<br />ABC123 MyCity<br />France' }

        context 'when only country is present' do
          let(:expanded) { false }

          before do
            merchant.house_number = ''
            merchant.street = ''
            merchant.postcode = ''
            merchant.city = ''
          end

          it { is_expected.to eq 'France' }
        end
      end

      context 'when expanded is false' do
        let(:expanded) { false }

        it { is_expected.to eq '3 Square Street ABC123 MyCity<br />France' }

        context 'when only country is present' do
          let(:expanded) { false }

          before do
            merchant.house_number = ''
            merchant.street = ''
            merchant.postcode = ''
            merchant.city = ''
          end

          it { is_expected.to eq 'France' }
        end
      end
    end
  end
end
