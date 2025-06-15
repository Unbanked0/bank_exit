# This class acts as a model (not related to the database)
# to interact more elegantly with the Glossary data.
class Glossary
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :letter, :string
  attribute :acronym, :string
  attribute :original_full_title, :string
  attribute :translated_full_title, :string
  attribute :description, default: -> { [] }

  def self.load_from_yaml_file
    yaml_data = begin
      YAML.load_file("db/yaml/#{I18n.locale}/glossaries.#{I18n.locale}.yml")
    rescue StandardError
      YAML.load_file("db/yaml/#{I18n.default_locale}/glossaries.#{I18n.default_locale}.yml")
    end

    terms = []

    yaml_data.each do |group|
      group.each do |letter, entries|
        entries.each do |entry|
          terms << new(letter: letter, **entry)
        end
      end
    end

    terms
  end
end
