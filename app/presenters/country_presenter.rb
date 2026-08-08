class CountryPresenter
  def initialize(country)
    @code = normalize(country)
    @country = ISO3166::Country[@code]
  end

  def display(show_flag: true, show_label: true)
    return name unless show_flag
    return flag unless show_label

    label_with_flag
  end

  def name
    return code unless country

    country.translations[I18n.locale.to_s] ||
      country.common_name ||
      country.iso_short_name
  end

  def flag
    return unless country

    country.emoji_flag
  end

  def label_with_flag
    [flag, name].compact.join(' ')
  end

  private

  attr_reader :country, :code

  def normalize(country)
    country == 'en' ? 'gb' : country
  end
end
