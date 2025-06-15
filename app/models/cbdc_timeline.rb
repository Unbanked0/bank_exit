class CBDCTimeline
  include ActiveModel::Model
  include ActiveModel::Attributes
  include Findable

  attribute :started_on, :date
  attribute :title, :string

  attribute :missing_content_for_locale, :boolean, default: false

  attr_accessor :description
end
