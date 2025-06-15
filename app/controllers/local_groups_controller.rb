class LocalGroupsController < ApplicationController
  # @route GET /fr/groupes-locaux {locale: "fr"} (local_groups_fr)
  # @route GET /es/grupos-locales {locale: "es"} (local_groups_es)
  # @route GET /en/local-groups {locale: "en"} (local_groups_en)
  # @route GET /local_groups
  def index
    @local_groups = LocalGroup.all
  end
end
