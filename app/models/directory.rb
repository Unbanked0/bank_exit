class Directory < ApplicationRecord
  ACCEPTED_CONTENT_TYPES = ['image/png', 'image/jpeg'].freeze

  attr_accessor :remove_logo, :remove_banner

  attribute :from_proposition, :boolean, default: false

  belongs_to :merchant, optional: true
  has_one :address, as: :addressable, dependent: :destroy
  has_many :coin_wallets, as: :walletable, dependent: :destroy
  has_many :contact_ways, as: :contactable, dependent: :destroy
  has_many :delivery_zones, as: :deliverable, dependent: :destroy
  has_many :weblinks, as: :weblinkable, dependent: :destroy

  accepts_nested_attributes_for :address, reject_if: :all_blank
  accepts_nested_attributes_for :coin_wallets, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :contact_ways, allow_destroy: true
  accepts_nested_attributes_for :delivery_zones, allow_destroy: true
  accepts_nested_attributes_for :weblinks, allow_destroy: true

  positioned

  has_one_attached :logo do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100], preprocessed: true
  end
  has_one_attached :banner do |attachable|
    attachable.variant :thumb, resize_to_limit: [1024, 768], preprocessed: true
  end

  validates :name, presence: true
  validates :category, presence: true, inclusion: { in: :allowed_categories }, if: :from_proposition?
  validates :category, allow_blank: true, inclusion: { in: :allowed_categories }, unless: :from_proposition?
  validates :description, presence: true, if: :from_proposition?
  validates_associated :coin_wallets
  validates_associated :contact_ways
  validates_associated :delivery_zones
  validates_associated :weblinks

  validates :logo, :banner,
            content_type: {
              in: ACCEPTED_CONTENT_TYPES,
              spoofing_protection: true
            },
            size: { less_than: 1.megabyte }

  before_save :purge_logo_if_requested
  before_save :purge_banner_if_requested

  scope :by_position, -> { order(position: :asc) }
  scope :enabled, -> { where(enabled: true) }
  scope :disabled, -> { where(enabled: false) }
  scope :spotlights, -> { where(spotlight: true) }
  scope :by_category, ->(category) { where(category: category) }
  scope :by_query, lambda { |query|
    where('name LIKE :query', query: "%#{query}%")
      .or(where('description LIKE :query', query: "%#{query}%"))
  }
  scope :by_coins, lambda { |coins|
    # Handle BTC onchain and Lightning in a similar way
    coins <<= 'lightning' if coins.include?('bitcoin')
    joins(:coin_wallets).where(coin_wallets: { coin: coins })
  }

  def allowed_categories
    I18n.t('directories_categories').keys.map(&:to_s)
  end

  def to_param
    [id, slug].join('-')
  end

  def slug
    name.parameterize
  end

  private

  def purge_logo_if_requested
    logo.purge if ActiveModel::Type::Boolean.new.cast(remove_logo)
  end

  def purge_banner_if_requested
    banner.purge if ActiveModel::Type::Boolean.new.cast(remove_banner)
  end
end

# == Schema Information
#
# Table name: directories
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text
#  category    :string
#  spotlight   :boolean          default(FALSE), not null
#  enabled     :boolean          default(TRUE), not null
#  position    :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  merchant_id :integer
#
# Indexes
#
#  index_directories_on_category     (category)
#  index_directories_on_merchant_id  (merchant_id)
#  index_directories_on_position     (position) UNIQUE
#
# Foreign Keys
#
#  merchant_id  (merchant_id => merchants.id)
#
