# This class acts as a model (not related to the database)
# to interact more elegantly with the projects data.
class Project
  include ActiveModel::Model
  include ActiveModel::Attributes
  include Findable

  attribute :identifier, :string
  attribute :title, :string
  attribute :description, :string
  attribute :image, :string
  attribute :website_screenshot, :string
  attribute :iframe_url, :string
  attribute :github_url, :string
  attribute :url, :string
  attribute :route, :string
  attribute :external, :boolean
  attribute :missing_content_for_locale, :boolean, default: false

  attr_accessor :model
  attr_writer :figure

  def initialize(model)
    super
    @model = model.with_indifferent_access
  end

  def video
    return unless video?

    Article::Video.new(
      **model.dig(:figure, :video).slice(:title, :url, :created_at).symbolize_keys
    )
  end

  def video?
    model.dig(:figure, :video).present?
  end
end
