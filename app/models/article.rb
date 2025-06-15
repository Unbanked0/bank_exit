class Article
  include ActiveModel::Model
  include ActiveModel::Attributes
  include Findable

  CONTENT_KEYS = %i[title body mode render figure url].freeze

  attribute :identifier, :string
  attribute :title, :string
  attribute :short_title, :string
  attribute :banner, :string
  attribute :short_description, :string
  attribute :created_at, :date
  attribute :highlight, :boolean, default: false
  attribute :missing_content_for_locale, :boolean, default: false

  attr_accessor :model
  attr_writer :content, :figure, :useful_links, :url

  def initialize(model)
    super
    @model = model.with_indifferent_access
  end

  def to_param
    identifier
  end

  def contents
    return [] unless model[:content]

    model[:content].map do |content|
      Article::Content.new(
        **content.slice(*CONTENT_KEYS).symbolize_keys
      )
    end
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

  def useful_links
    model[:useful_links]&.map do |link|
      UsefulLink.new(*link.values)
    end
  end

  def useful_links?
    model[:useful_links].present?
  end
end
