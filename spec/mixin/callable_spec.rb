require 'rails_helper'

RSpec.describe Mixin::Callable do
  let(:foobar) do
    Class.new do
      include Mixin::Callable

      def self.name
        'FooBar'
      end

      def initialize(*args)
        @args = args
      end

      def call
        @args.join(',')
      end
    end
  end

  describe '.call' do
    subject(:call) { foobar.call('foo') }

    it { is_expected.to eq 'foo' }

    context 'when subclass not implemented call' do
      before do
        foobar.remove_method(:call)
      end

      it { expect { call }.to raise_error(NotImplementedError) }
    end
  end

  describe '.call_later' do
    subject(:call_later) { foobar.call_later('foo') }

    it { expect { call_later }.to have_enqueued_job.with(foobar.name, 'foo') }
  end

  describe '.queue' do
    subject(:call_later) { foobar.call_later('foo') }

    let(:queue) { 'foobar' }

    before { foobar.queue(queue) }

    it { expect { call_later }.to have_enqueued_job.with(foobar.name, 'foo').on_queue(queue) }
  end
end
