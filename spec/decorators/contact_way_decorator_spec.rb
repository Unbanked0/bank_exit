require 'rails_helper'

RSpec.describe ContactWayDecorator do
  let(:decorator) { contact_way.decorate }

  describe '#clean_url' do
    subject { decorator.clean_url }

    context 'when value starts_with http://' do
      let(:contact_way) do
        build :contact_way, value: 'http://foobar.com'
      end

      it { is_expected.to eq 'foobar.com' }
    end

    context 'when value starts_with https://' do
      let(:contact_way) do
        build :contact_way, value: 'https://foobar.com'
      end

      it { is_expected.to eq 'foobar.com' }
    end

    context 'when value starts_with www.' do
      let(:contact_way) do
        build :contact_way, value: 'www.foobar.com'
      end

      it { is_expected.to eq 'foobar.com' }
    end

    context 'when value starts_with http(s)://www.' do
      let(:contact_way) do
        build :contact_way, value: 'https://www.foobar.com'
      end

      it { is_expected.to eq 'foobar.com' }
    end

    context 'when value ends_with /' do
      let(:contact_way) do
        build :contact_way, value: 'https://www.foobar.com/'
      end

      it { is_expected.to eq 'foobar.com' }
    end

    context 'when value ends_with www.' do
      let(:contact_way) do
        build :contact_way, value: 'https://www.foobar.com/www.'
      end

      it { is_expected.to eq 'foobar.com/www.' }
    end
  end
end
