class CBDCTimeline
  include ActiveModel::Model
  include ActiveModel::Attributes
  include Findable

  attribute :started_on, :date
  attribute :title, :string

  attr_accessor :description
end
