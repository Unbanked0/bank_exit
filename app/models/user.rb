class User < ApplicationRecord
  has_secure_password

  enum :role, {
    super_admin: 0,
    admin: 1,
    publisher: 2,
    moderator: 3
  }, validate: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  encrypts :email_address, deterministic: true

  has_many :sessions, dependent: :destroy

  validates :email_address, presence: true, uniqueness: true

  with_options if: -> { new_record? || password.present? } do
    validates :password, length: { minimum: 8 }
    validates :password, confirmation: true
    validates :password_confirmation, presence: true
  end

  scope :enabled, -> { where(enabled: true) }
end

# == Schema Information
#
# Table name: users
# Database name: primary
#
#  id              :integer          not null, primary key
#  email_address   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  role            :integer          default("moderator"), not null
#  enabled         :boolean          default(FALSE), not null
#  password_digest :string
#
# Indexes
#
#  index_users_on_email_address  (email_address) UNIQUE
#
