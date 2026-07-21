class MobilitySearch
  class << self
    def call(relation, query, attributes: nil)
      return relation if query.blank?

      new(relation, query, attributes:).call
    end
  end

  def initialize(relation, query, attributes: nil)
    @relation = relation
    @model = relation.klass
    @query = query
    @attributes = attributes
  end

  def call
    build_joins

    relation
      .where(where_clause)
      .distinct
  end

  private

  attr_reader :relation, :model, :query, :attributes

  def searchable_attributes
    attributes || model.searchable_mobility_attributes.keys
  end

  def current_locale
    I18n.locale.to_s
  end

  def fallback_locale
    I18n.default_locale.to_s
  end

  def pattern
    "%#{ActiveRecord::Base.sanitize_sql_like(query)}%"
  end

  def build_joins
    searchable_attributes.each do |attribute|
      table = translation_table(attribute)
      current = current_alias(attribute)
      fallback = fallback_alias(attribute)

      sql = <<~SQL.squish
        LEFT JOIN #{table} #{current}
          ON #{current}.translatable_id = #{model.table_name}.id
         AND #{current}.translatable_type = ?
         AND #{current}.key = ?
         AND #{current}.locale = ?

        LEFT JOIN #{table} #{fallback}
          ON #{fallback}.translatable_id = #{model.table_name}.id
         AND #{fallback}.translatable_type = ?
         AND #{fallback}.key = ?
         AND #{fallback}.locale = ?
      SQL

      sql = ActiveRecord::Base.send(
        :sanitize_sql_array,
        [
          sql,
          model.name,
          attribute.to_s,
          current_locale,
          model.name,
          attribute.to_s,
          fallback_locale
        ]
      )

      @relation = relation.joins(sql)
    end
  end

  def where_clause
    sql = searchable_attributes.map do |attribute|
      <<~SQL.squish
        COALESCE(
          #{current_alias(attribute)}.value,
          #{fallback_alias(attribute)}.value
        ) LIKE :pattern
      SQL
    end.join(' OR ')

    ActiveRecord::Base.send(
      :sanitize_sql_array,
      [sql, { pattern: pattern }]
    )
  end

  def translation_table(attribute)
    type =
      model.searchable_mobility_attributes[attribute]

    case type.to_sym
    when :string
      'mobility_string_translations'
    when :text
      'mobility_text_translations'
    else
      raise ArgumentError, "Unsupported Mobility type #{type.inspect} for #{attribute}"
    end
  end

  def current_alias(attribute)
    "#{attribute}_mobility_current"
  end

  def fallback_alias(attribute)
    "#{attribute}_mobility_fallback"
  end
end
