module MobilitySearchable
  extend ActiveSupport::Concern

  included do
    class_attribute :searchable_mobility_attributes,
                    instance_accessor: false,
                    default: {}

    scope :mobility_search, lambda { |query, attributes: nil|
      MobilitySearch.call(self, query, attributes:)
    }
  end

  class_methods do
    def searchable_by(attributes_with_types)
      self.searchable_mobility_attributes ||= {}

      attributes_with_types.each do |attr, type|
        unless mobility_attributes.include?(attr.to_s)
          raise ArgumentError,
                "Attribute #{attr} is not a translated Mobility attribute"
        end

        unless %i[string text].include?(type)
          raise ArgumentError,
                "Unsupported Mobility type #{type.inspect} for #{attr}"
        end

        searchable_mobility_attributes[attr.to_sym] = type
      end
    end

    def mobility_search(query, attributes: nil)
      MobilitySearch.call(all, query, attributes:)
    end
  end
end
