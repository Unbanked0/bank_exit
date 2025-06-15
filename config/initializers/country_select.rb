CountrySelect::FORMATS[:with_flag] = lambda do |country|
  label = country.translations&.send(:[], I18n.locale.to_s) || country.common_name || country.iso_short_name

  "#{country.emoji_flag} #{label}"
end
