module AddressesHelper
  def formatted_address(address)
    safe_join(address, tag.br)
  end

  def formatted_country(country, show_flag: true, show_label: true)
    CountryPresenter
      .new(country)
      .display(show_flag:, show_label:)
  end
end
