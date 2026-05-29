module Merchants
  class OSMConverter < ApplicationService
    SOCIAL_NETWORKS = %i[
      facebook twitter instagram youtube tiktok
      telegram matrix jabber linkedin tripadvisor
      odysee crowdbunker francelibretv
    ].freeze

    attr_reader :merchant_proposal

    def initialize(merchant_proposal)
      @merchant_proposal = merchant_proposal.decorate
      @data = []
    end

    delegate :name, :description,
             :other_category,
             :other_category_selected?,
             :street, :postcode, :city, :country,
             :email, :phone, :website, :opening_hours,
             :coins, :ask_kyc, :latitude, :longitude,
             :delivery, :delivery_zone, :last_survey_on,
             to: :merchant_proposal

    def call
      set_main_properties_keys
      set_main_contact_keys
      set_address_and_location_keys
      set_coins_keys
      set_social_contact_keys
      set_other_keys
      set_source_key

      transform_to_key_equal_value
    end

    private

    def set_main_properties_keys
      @data << ['name', name]
      @data << ['category', category]
      @data << ['description', description&.squish] if description
    end

    def set_address_and_location_keys
      @data << ['addr:street', street] if street
      @data << ['addr:postcode', postcode] if postcode
      @data << ['addr:city', city] if city

      return unless country

      @data << ['addr:country', country]
    end

    def set_main_contact_keys
      @data << ['email', email] if email
      @data << ['phone', phone] if phone
      @data << ['website', website] if website
    end

    def set_social_contact_keys
      SOCIAL_NETWORKS.each do |social|
        next unless merchant_proposal.send("contact_#{social}")

        @data << ["contact:#{social}", send("contact_#{social}_url")]
      end
    end

    def set_coins_keys
      @data << ['payment:onchain', 'yes'] if coins.intersect?(%w[bitcoin monero june])

      @data << ['currency:XBT', 'yes'] if 'bitcoin'.in?(coins)
      @data << ['currency:XMR', 'yes'] if 'monero'.in?(coins)
      @data << ['currency:XG1', 'yes'] if 'june'.in?(coins)
      @data << ['payment:lightning', 'yes'] if 'lightning'.in?(coins)
      @data << ['payment:lightning_contactless', 'yes'] if 'contact_less'.in?(coins)
      @data << ['payment:silver', 'yes'] if 'silver'.in?(coins)
      @data << ['payment:gold', 'yes'] if 'gold'.in?(coins)

      return if ask_kyc.nil?

      @data << ['payment:kyc', ask_kyc ? 'yes' : 'no']
    end

    def set_source_key
      @data << ['source', '<insert Github issue URL here>']
    end

    def set_other_keys
      if delivery
        @data << %w[delivery yes]
        @data << ['delivery_zone', delivery_zone] if delivery_zone
      end

      @data << ['opening_hours', opening_hours] if opening_hours
      @data << ['survey:date', last_survey_on] if last_survey_on
    end

    def transform_to_key_equal_value
      @data.map do |key, value|
        next if value.blank?

        "#{key}=#{value}"
      end.compact_blank.join("\n").chomp
    end

    SOCIAL_NETWORKS.each do |social|
      define_method "contact_#{social}_url" do
        SocialUrlPrefixer.call(
          social == :twitter ? :x : social,
          merchant_proposal.send("contact_#{social}")
        )
      end
    end

    def category
      return other_category if other_category_selected?

      I18n.t(
        merchant_proposal.category,
        scope: 'categories',
        default: merchant_proposal.category
      )
    end
  end
end
