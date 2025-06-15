module Questions
  class BuildProfiles < ApplicationService
    def call
      [
        [I18n.t('individual', scope: i18n_scope), :individual],
        [I18n.t('company', scope: i18n_scope), :company],
        [I18n.t('association', scope: i18n_scope), :associations],
        [I18n.t('politic', scope: i18n_scope), :politic]
      ]
    end

    private

    def i18n_scope
      %i[questions]
    end
  end
end
