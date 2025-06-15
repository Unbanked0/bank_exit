require 'rails_helper'

RSpec.describe Merchant do
  it_behaves_like 'deletable model', described_class

  describe '.by_query' do
    subject { described_class.by_query(query) }

    let(:query) { 'dentist' }

    describe '[name]' do
      let!(:merchant_name_uppercase) { create :merchant, name: 'The DENTIST show' }
      let!(:merchant_name_lowercase) { create :merchant, name: 'The dentist show' }
      let!(:merchant_name_camelcase) { create :merchant, name: 'The DenTist show' }

      before do
        create :merchant, name: 'Does not match'
      end

      it { is_expected.to contain_exactly(merchant_name_uppercase, merchant_name_lowercase, merchant_name_camelcase) }
    end

    describe '[full_address]' do
      let!(:merchant_match_address_lowercase) { create :merchant, full_address: '1 street dentist, MyCity' }
      let!(:merchant_match_address_uppercase) { create :merchant, full_address: '1 DENTIST street, MyCity' }

      before do
        create :merchant, full_address: 'Does not match'
      end

      it { is_expected.to contain_exactly(merchant_match_address_lowercase, merchant_match_address_uppercase) }
    end

    describe '[description]' do
      let!(:merchant_match_description_lowercase) { create :merchant, description: 'Lorem ipsum dentist dolor sit amet' }
      let!(:merchant_match_description_uppercase) { create :merchant, description: 'Lorem ipsum DeNtIsT sit amet' }

      before do
        create :merchant, description: 'Does not match'
      end

      it { is_expected.to contain_exactly(merchant_match_description_lowercase, merchant_match_description_uppercase) }
    end

    describe '[category]' do
      let!(:merchant_match_category_lowercase) { create :merchant, category: 'dentist' }
      let!(:merchant_match_category_uppercase) { create :merchant, category: 'DENTIST' }

      before do
        create :merchant, category: 'hotel'
      end

      it { is_expected.to contain_exactly(merchant_match_category_lowercase, merchant_match_category_uppercase) }
    end

    describe '[identifier]' do
      let!(:merchant) { create :merchant, identifier: 'dentist' }

      before do
        create :merchant, identifier: 'dent'
        create :merchant, identifier: 'hotel'
      end

      it { is_expected.to contain_exactly(merchant) }
    end
  end

  describe '.by_category' do
    subject { described_class.by_category(category) }

    let(:category) { 'handicraft' }
    let(:merchant) { create :merchant, category: 'handicraft' }

    before do
      create :merchant, category: 'restaurant'
    end

    it { is_expected.to contain_exactly(merchant) }
  end

  describe '.bitcoin' do
    subject { described_class.bitcoin }

    let!(:merchant_bitcoin) { create :merchant, bitcoin: true }

    before do
      create :merchant, monero: true, bitcoin: false
      create :merchant, june: true, bitcoin: false
    end

    it { is_expected.to contain_exactly(merchant_bitcoin) }
  end

  describe '.monero' do
    subject { described_class.monero }

    let!(:merchant_monero) { create :merchant, monero: true }

    before do
      create :merchant, bitcoin: true, monero: false
      create :merchant, june: true, monero: false
    end

    it { is_expected.to contain_exactly(merchant_monero) }
  end

  describe '.june' do
    subject { described_class.june }

    let!(:merchant_june) { create :merchant, june: true }

    before do
      create :merchant, bitcoin: true, june: false
      create :merchant, monero: true, june: false
    end

    it { is_expected.to contain_exactly(merchant_june) }
  end
end
