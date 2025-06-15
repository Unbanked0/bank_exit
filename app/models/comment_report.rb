class CommentReport
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :description, :string
  attribute :nickname, :string
  attribute :flag_reason, :string

  validates :description, presence: true
  validates :flag_reason, presence: true,
                          inclusion: { in: Comment.flag_reasons.keys }
  validates :nickname, absence: true # Captcha to trick bots
end
