class Article < StaticContent
  attribute :identifier, :string
  attribute :title, :string
  attribute :short_title, :string
  attribute :banner, :string
  attribute :short_description, :string
  attribute :created_at, :date
  attribute :highlight, :boolean, default: false

  def self.human_count(count, pretty_count:)
    "<strong>#{pretty_count}</strong> #{model_name.human(count: count)}"
  end

  def short_description
    super || render_template.truncate(250)
  end

  def highlight?
    highlight == true
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
