module AddressesHelper
  def formatted_address(address)
    safe_join(address, tag.br)
  end

  def pretty_country_html(country, show_label: true, show_flag: true)
    country = 'gb' if country == 'en'
    c = ISO3166::Country[country]

    name = c.translations[I18n.locale.to_s] ||
           c.common_name || c.iso_short_name

    return name unless show_flag

    flag = c.emoji_flag
    return "#{flag} #{name}" if show_label && show_flag

    flag
  rescue StandardError
    country
  end
end
