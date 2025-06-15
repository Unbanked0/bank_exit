class TutorialReport
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :title, :string
  attribute :description, :string
  attribute :nickname, :string

  validates :title, presence: true
  validates :description, presence: true
  validates :nickname, absence: true # Captcha to trick bots
end
