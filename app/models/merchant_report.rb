class MerchantReport
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :description, :string
  attribute :nickname, :string

  validates :description, presence: true
  validates :nickname, absence: true # Captcha to trick bots
end
