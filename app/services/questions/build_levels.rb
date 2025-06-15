module Questions
  class BuildLevels < ApplicationService
    attr_reader :profile

    def initialize(profile = :zero_knowledge)
      @profile = profile.to_sym
    end

    def call
      [
        [I18n.t('zero_knowledge', scope: i18n_scope), :zero_knowledge],
        [I18n.t('beginner', scope: i18n_scope), :beginner],
        [I18n.t('intermediate', scope: i18n_scope), :intermediate],
        [I18n.t('expert', scope: i18n_scope), :expert]
      ]
    end

    private

    def i18n_scope
      %i[questions]
    end
  end
end
