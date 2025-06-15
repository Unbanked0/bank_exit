module Questions
  class BuildResponse < ApplicationService
    include Rails.application.routes.url_helpers

    attr_reader :profile, :level, :service

    def initialize(profile, level, service)
      @profile = profile.to_sym
      @level = level.to_sym
      @service = service&.to_sym
    end

    def call
      return { type: :redirect, to: :root_path } unless valid?

      case service
      when :accounting
        { type: :redirect, to: :tutorial_path, id: 'accounting' }
      when :messaging
        { type: :redirect, to: :tutorial_path, id: 'session-messaging' }
      when :social_network
        { type: :redirect, to: :tutorial_path, id: 'nostr-social-network' }
      when :buy_no_kyc
        { type: :redirect, to: :tutorial_path, id: 'bitcoin-nokyc' }
      when :kitty
        { type: :redirect, to: :tutorial_path, id: 'funding-monero' }
      when :debank
        { type: :redirect, to: :tutorial_path, id: 'crash-course' }
      when :node
        { type: :redirect, to: :tutorial_path, id: 'monero-node-easymonerod' }
      when :anonymous
        { type: :redirect, to: :tutorial_path, id: 'cakewallet-monero' }
      else
        { type: :render }
      end
    end

    private

    def valid?
      profile.present? && level.present? && service.present?
    end
  end
end
