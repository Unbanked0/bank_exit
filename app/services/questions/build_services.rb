module Questions
  class BuildServices < ApplicationService
    attr_reader :profile, :level

    def initialize(profile, level)
      @profile = profile.to_sym
      @level = level.to_sym
    end

    def call
      case level
      when :zero_knowledge, :beginner then services_for_beginner
      when :intermediate then services_for_intermediate
      when :expert then services_for_expert
      else
        []
      end
    end

    private

    def services_for_beginner
      services = [
        [I18n.t('.debank', scope: i18n_scope), :debank],
        [I18n.t('.privacy', scope: i18n_scope), :privacy],
        [I18n.t('.anonymous', scope: i18n_scope), :anonymous],
        [I18n.t('.inflation', scope: i18n_scope), :inflation],
        [I18n.t('.messaging', scope: i18n_scope), :messaging],
        [I18n.t('.social_network', scope: i18n_scope), :social_network],
        [I18n.t('.help', scope: i18n_scope), :help]
      ]

      services << [I18n.t('.accounting', scope: i18n_scope), :accounting]
      services
    end

    def services_for_intermediate
      services = [
        [I18n.t('.buy_btc', scope: i18n_scope), :buy_btc],
        [I18n.t('.buy_xmr', scope: i18n_scope), :buy_xmr],
        [I18n.t('.convert', scope: i18n_scope), :convert],
        [I18n.t('.spend', scope: i18n_scope), :spend],
        [I18n.t('.kitty', scope: i18n_scope), :kitty]
      ]

      services << [I18n.t('.accounting', scope: i18n_scope), :accounting]
      services
    end

    def services_for_expert
      [
        [I18n.t('.buy_no_kyc', scope: i18n_scope), :buy_no_kyc],
        [I18n.t('.node', scope: i18n_scope), :node],
        [I18n.t('.tor_ipfs', scope: i18n_scope), :tor_ipfs]
      ]
    end

    def i18n_scope
      %i[questions fetch_services]
    end
  end
end
