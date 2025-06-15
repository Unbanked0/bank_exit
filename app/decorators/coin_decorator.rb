class CoinDecorator < ApplicationDecorator
  include CoinsHelper

  def image
    icon_by_coin(identifier)
  end
end
