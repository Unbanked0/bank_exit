class GlossariesController < ApplicationController
  # @route GET /fr/glossaire {locale: "fr"} (glossaries_fr)
  # @route GET /es/glosario {locale: "es"} (glossaries_es)
  # @route GET /en/glossary {locale: "en"} (glossaries_en)
  # @route GET /glossaries
  def show
    glossaries = Glossary.load_from_yaml_file
    @glossaries = glossaries.group_by(&:letter)
  end
end
