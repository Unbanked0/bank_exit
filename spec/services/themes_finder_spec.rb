require 'rails_helper'

RSpec.describe ThemesFinder do
  let(:instance) do
    described_class.new(date)
  end
  let(:date) { Date.new(2026, 5, 1) } # May 1st

  before { travel_to date }

  describe '#call' do
    subject { instance.call }

    context 'when during regular time' do
      let(:date) { Date.new(2025, 3, 1) } # March 1st

      it { is_expected.to eq({ light: :silk, dark: :dracula }) }
    end
  end

  describe '#christmas_time?' do
    subject { instance.christmas_time? }

    context 'when snowflakes feature is disabled' do
      before do
        disable_feature(:snowflakes)
      end

      context 'when before Christmas time' do
        let(:date) { Date.new(2025, 12, 1) } # December 1st

        it { is_expected.to be false }
      end

      context 'when during Christmas time' do
        let(:date) { Date.new(2025, 12, 25) } # December 25

        it { is_expected.to be false }
      end

      context 'when after Christmas time' do
        let(:date) { Date.new(2026, 1, 8) } # January 8

        it { is_expected.to be false }
      end
    end

    context 'when snowflakes feature is enabled' do
      before do
        enable_feature(:snowflakes)
      end

      context 'when before Christmas time' do
        let(:date) { Date.new(2025, 12, 1) } # December 1st

        it { is_expected.to be false }
      end

      context 'when during Christmas time' do
        let(:date) { Date.new(2025, 12, 25) } # December 25

        it { is_expected.to be true }
      end

      context 'when during new year time' do
        let(:date) { Date.new(2026, 1, 2) } # January 2nd

        it { is_expected.to be true }
      end

      context 'when after Christmas time' do
        let(:date) { Date.new(2026, 1, 20) } # January 20

        it { is_expected.to be false }
      end
    end
  end
end
