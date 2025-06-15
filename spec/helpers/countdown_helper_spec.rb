require 'rails_helper'

RSpec.describe CountdownHelper do
  describe '#countdown_to' do
    subject(:result) { helper.countdown_to(deadline) }

    context 'when the deadline is in the past' do
      let(:deadline) { Time.zone.local(2025, 5, 10, 0, 0, 0) }

      it 'returns all zeros' do
        travel_to(Time.zone.local(2025, 5, 15, 12, 0, 0)) do
          expect(result).to eq(
            months: 0, days: 0, hours: 0, minutes: 0, seconds: 0
          )
        end
      end
    end

    context 'when the deadline is a few seconds ahead' do
      let(:deadline) { Time.zone.local(2025, 5, 15, 12, 1, 40) }

      it 'returns the correct short countdown' do
        travel_to(Time.zone.local(2025, 5, 15, 12, 0, 0)) do
          expect(result).to eq(
            months: 0, days: 0, hours: 0, minutes: 1, seconds: 40
          )
        end
      end
    end

    context 'when the deadline is more than a month away' do
      let(:deadline) { Time.zone.local(2025, 7, 20, 14, 30, 0) }

      it 'returns correct months and remaining time', :aggregate_failures do
        travel_to(Time.zone.local(2025, 5, 15, 12, 0, 0)) do
          expect(result[:months]).to eq(2)
          expect(result[:days]).to be >= 4
          expect(result[:hours]).to be_between(0, 23)
        end
      end
    end

    context 'when starting from Jan 31 and going to March 1' do
      let(:deadline) { Time.zone.local(2025, 3, 1, 0, 0, 0) }

      it 'handles end-of-month correctly', :aggregate_failures do
        travel_to(Time.zone.local(2025, 1, 31, 0, 0, 0)) do
          expect(result[:months]).to eq(1)
          expect(result[:days]).to be_between(0, 31)
        end
      end
    end

    context 'when during a leap year (Feb 28 to Mar 1)' do
      let(:deadline) { Time.zone.local(2024, 3, 1, 12, 0, 0) }

      it 'handles February 29 correctly', :aggregate_failures do
        travel_to(Time.zone.local(2024, 2, 28, 12, 0, 0)) do
          expect(result[:months]).to eq(0)
          expect(result[:days]).to eq(2)
        end
      end
    end
  end
end
