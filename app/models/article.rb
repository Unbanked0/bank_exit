class Article < StaticContent
  LEVELS = %i[beginner intermediate expert].freeze

  attribute :identifier, :string
  attribute :title, :string
  attribute :short_title, :string
  attribute :author, :string
  attribute :banner, :string
  attribute :overview, :string
  attribute :created_at, :date
  attribute :highlight, :boolean, default: false
  attribute :time, :integer
  attr_writer :level

  def level
    return nil unless model[:level]

    LEVELS[model[:level]]
  end

  def highlight?
    highlight == true
  end

  def logo?
    Rails.root.join("app/assets/images/#{logo}").exist?
  end

  def video?
    video_figure.present?
  end

  def video_url
    video_figure
      &.at_css('iframe')
      &.[]('src')
  end

  def video_title
    text = video_figure&.at_css('figcaption span')&.text
    text&.strip&.presence
  end

  private

  def video_figure
    @video_figure ||= begin
      doc = Nokogiri::HTML.fragment(render_template)

      doc.css('figure').find do |figure|
        iframe = figure.at_css('iframe')
        iframe && iframe['src']&.include?('youtube.com/embed')
      end
    end
  end
end
