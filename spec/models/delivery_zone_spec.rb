require 'rails_helper'

RSpec.describe DeliveryZone do
  it { is_expected.to define_enum_for(:mode).with_values(described_class.modes.keys) }

  context 'when :mode is not :world' do
    subject { build :delivery_zone, mode: :country }

    it { is_expected.to validate_presence_of(:value) }
  end

  context 'when :mode is :world' do
    subject { build :delivery_zone, mode: :world }

    it { is_expected.to_not validate_presence_of(:value) }
  end
end
