class Coin
  include ActiveModel::Model
  include ActiveModel::Attributes
  include Findable

  attribute :identifier, :string
  attribute :name, :string
  attribute :ticker, :string
  attribute :usage, :string

  attr_accessor :links, :description

  def ticker?
    ticker.present?
  end

  def links?
    links.present?
  end
end
