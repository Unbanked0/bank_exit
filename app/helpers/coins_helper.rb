module CoinsHelper
  def icon_by_coin(coin)
    case coin.to_sym
    when :gold then 'coins/logo-gold.webp'
    when :silver then 'coins/logo-silver.jpg'
    else
      "coins/logo-#{coin}.svg"
    end
  end

  def highlight_address(address)
    chars_to_highlight = 7

    return address if address.length <= chars_to_highlight * 2

    first_part = address[0, chars_to_highlight]
    last_part = address[-chars_to_highlight, chars_to_highlight]
    middle_part = address[chars_to_highlight...-chars_to_highlight]

    "<span class='text-primary mr-1'>#{first_part}</span>#{middle_part}<span class='text-primary ml-1'>#{last_part}</span>"
  end

  def coin_link_address_with_protocol(coin, address)
    protocol = coin
    protocol = 'g1' if coin == 'june'

    "#{protocol}://#{address}"
  end

  def qr_code_for_coin_wallet(coin_wallet, show_logo: false)
    return unless coin_wallet&.public_address

    qr = RQRCode::QRCode.new(coin_wallet.public_address)
    svg = qr.as_svg(
      fill: :white,
      offset: 10,
      color: '000',
      shape_rendering: 'crispEdges',
      module_size: 6,
      standalone: true,
      use_path: true,
      svg_attributes: { class: 'max-w-xl mx-auto rounded-lg border' }
    )

    if show_logo
      content_tag(:div, class: 'relative') do
        concat raw(svg) # rubocop:disable Rails/OutputSafety
        concat image_tag(icon_by_coin(coin_wallet.coin), class: 'absolute-center w-12 h-12') if show_logo
      end
    else
      raw(svg) # rubocop:disable Rails/OutputSafety
    end
  end
end
