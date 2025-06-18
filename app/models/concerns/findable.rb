module Findable
  extend ActiveSupport::Concern

  included do
    attribute :missing_content_for_locale, :boolean, default: false

    def self.all(decorate: false)
      folder = name.underscore.pluralize.downcase

      default_data = YAML.load_file(
        "db/yaml/#{I18n.default_locale}/#{folder}.#{I18n.default_locale}.yml",
        permitted_classes: [Date]
      )

      data = begin
        YAML.load_file(
          "db/yaml/#{I18n.locale}/#{folder}.#{I18n.locale}.yml",
          permitted_classes: [Date]
        )
      rescue Errno::ENOENT
        default_data.map do |d_data|
          d_data['missing_content_for_locale'] = true
          d_data
        end
      end

      # Inject missing content from default locale if contents
      # are not all present.
      if I18n.locale != I18n.default_locale
        default_data.each do |d_data|
          next if data.any? { it['identifier'] == d_data['identifier'] }

          d_data['missing_content_for_locale'] = true
          data << d_data
        end
      end

      data.map do |row|
        if decorate
          decorator = "#{name}Decorator".constantize
          decorator.new(new(row))
        else
          new(row)
        end
      end
    end

    def self.find(identifier, decorate: false)
      record = all(decorate: decorate).find { it.identifier == identifier }

      raise ActiveRecord::RecordNotFound unless record

      record
    end

    def self.where(identifiers)
      all.select { it.identifier.in?(identifiers) }
    end
  end
end
