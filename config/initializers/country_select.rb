# NOTE: Kosovo does not have an ISO 3166-1 alpha-2 code yet and as such
# is not included in the "countries" gem.
ISO3166::Data.register(
  alpha2: 'XK',
  alpha3: 'XKX',
  name: 'Kosovo',
  currency: 'EUR',
  translations: {
    'en' => 'Kosovo'
  }
)

CountrySelect::FORMATS[:with_flag] = lambda do |country|
  label = country.translations&.send(:[], I18n.locale.to_s) || country.common_name || country.iso_short_name

  "#{country.emoji_flag} #{label}"
end
