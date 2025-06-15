module Merchants
  class AssignCountry < ApplicationService
    def call
      merchants.find_in_batches(batch_size: 300) do |group|
        @updated_merchants = []

        group.each do |merchant|
          latitude = merchant.latitude
          longitude = merchant.longitude

          next unless latitude && longitude

          results = Geocoder.search([latitude, longitude])

          result = results.first
          country = result&.country
          country_code = result&.country_code&.upcase

          next unless country_code

          # Use accurate French DOM/TOM country code
          # instead of the main country
          country_code = handle_country_state(result.state) || country_code

          # Assign corresponding continent for the
          # identified `country_code`.
          continent_code = COUNTRY_TO_CONTINENT[country_code]

          @updated_merchants << {
            id: merchant.id,
            osm_id: merchant.identifier,
            name: merchant.name,
            country: country_code,
            country_full_name: country,
            continent_code: continent_code
          }
        end

        if @updated_merchants.present?
          data = @updated_merchants.map { it.slice(:id, :country, :continent_code) }

          Merchant.upsert_all(data, unique_by: :id)

          log_updated_merchants
        end
      end
    end

    private

    def merchants
      @merchants ||= Merchant.where(country: nil)
    end

    def handle_country_state(state)
      {
        'French Polynesia' => 'PF',
        'Guadeloupe' => 'GP',
        'Martinique' => 'MQ',
        'Reunion' => 'RE',
        'Mayotte' => 'YT'
      }[state]
    end

    def log_updated_merchants
      output_folder = "#{files_folder_prefix}/merchants"
      FileUtils.mkdir_p(output_folder)

      File.write(
        "#{output_folder}/#{Time.current.to_fs(:number)}_merchants_assigned_country.json",
        JSON.pretty_generate(@updated_merchants)
      )
    end
  end
end
