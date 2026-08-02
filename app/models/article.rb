class Article < StaticContent
  attribute :identifier, :string
  attribute :title, :string
  attribute :short_title, :string
  attribute :banner, :string
  attribute :short_description, :string
  attribute :created_at, :date
  attribute :highlight, :boolean, default: false

  def overview
    nil
  end

  def short_description
    super || render_template.truncate(250)
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
