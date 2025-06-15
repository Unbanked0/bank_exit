module Directories
  class AroundMeFilter < ApplicationService
    attr_reader :relation, :geocoder

    def initialize(relation, geocoder)
      @relation = relation
      @geocoder = geocoder
    end

    def call
      match_conditions = build_hierarchical_match_conditions
      return relation.none if match_conditions.empty?

      sql, sql_params = build_sql_and_params(match_conditions)

      Rails.logger.debug { "SQL Query: #{sql}" }
      Rails.logger.debug { "SQL Params: #{sql_params}" }

      relation.includes(:delivery_zones)
              .joins(:delivery_zones)
              .where(delivery_zones: { enabled: true })
              .where(sql, sql_params)
    end

    private

    def build_hierarchical_match_conditions
      city_name = geocoder.city || geocoder.town
      country_code = geocoder.country_code&.upcase
      continent_code = COUNTRY_TO_CONTINENT[country_code]
      department_code = nil

      if country_code == 'FR'
        # Second geocoder call to retrieve french department
        # as it is not returned by :ipapi_com lookup
        result = Geocoder.search("#{city_name}, #{country_code}")&.first
        department_code = result.data.dig('address', 'ISO3166-2-lvl6') if result
        region_code = I18n.t('regions').find { it[0].ends_with?(geocoder.region) }.first.to_s
      else
        region_code = geocoder.region
      end

      conditions = []

      conditions << { mode: DeliveryZone.modes['city'], column: :city_name, value: city_name } if city_name.present?
      conditions << { mode: DeliveryZone.modes['department'], column: :department_code, value: department_code } if department_code.present?
      conditions << { mode: DeliveryZone.modes['region'], column: :region_code, value: region_code } if region_code.present?

      if country_code.present?
        conditions << { mode: DeliveryZone.modes['country'], column: :country_code, value: country_code }
        conditions << { mode: DeliveryZone.modes['continent'], column: :continent_code, value: continent_code }
      end

      conditions << { mode: DeliveryZone.modes['world'], column: :value, value: '' }

      log_matching_conditions(conditions)

      conditions
    end

    def log_matching_conditions(conditions)
      conditions.each do |condition|
        mode_name = DeliveryZone.modes.key(condition[:mode].to_i).to_s
        value = condition[:value] || 'nil'
        Rails.logger.debug { "Matching condition: Mode = #{mode_name}, Value = #{value}" }
      end
    end

    def build_sql_and_params(conditions)
      sql_parts = []
      params = {}

      conditions.each_with_index do |cond, i|
        mode_key  = :"mode_#{i}"
        value_key = :"value_#{i}"
        column    = cond[:column]

        sql_parts << "(delivery_zones.mode = :#{mode_key} AND delivery_zones.#{column} = :#{value_key})"

        params[mode_key] = cond[:mode]
        params[value_key] = cond[:value]
      end

      [sql_parts.join(' OR '), params]
    end
  end
end
