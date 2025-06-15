require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#pretty_country_html' do
    subject { pretty_country_html(country, show_flag: show_flag) }

    let(:country) { 'FR' }
    let(:show_flag) { false }

    it { is_expected.to eq 'France' }

    context 'when show_flag is true' do
      let(:show_flag) { true }

      it { is_expected.to eq '🇫🇷 France' }
    end

    context 'when country is not found' do
      let(:country) { 'Fake' }

      it { is_expected.to eq 'Fake' }
    end
  end
end
