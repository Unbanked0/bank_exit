require 'commonmarker'
require 'nokogiri'

module ActionView
  module Template::Handlers
    class Markdown
      OPTIONS = {
        parse: {
          smart: true
        },
        extension: {
          autolink: true,
          table: true,
          strikethrough: true,
          tasklist: true,
          alerts: true,
          header_ids: '',
          tagfilter: false
        },
        render: {
          unsafe: true,
          hardbreaks: false,
          alert_style: 'semantic'
        }
      }.freeze

      def self.call(template, source)
        erb_handler = ActionView::Template.registered_template_handler(:erb)

        previous = ActionView::Base.annotate_rendered_view_with_filenames

        begin
          ActionView::Base.annotate_rendered_view_with_filenames = false

          erb_source = erb_handler.call(template, source)

          <<~RUBY
            markdown = begin
              #{erb_source}
            end

            html = Commonmarker.to_html(
              markdown.to_s,
              options: #{OPTIONS.inspect}
            )

            fragment = Nokogiri::HTML::DocumentFragment.parse(html)

            fragment.css("a").each do |link|
              link["target"] = "_blank"
              link["rel"] = "noopener noreferrer"
            end

            fragment.css("aside.admonition").each do |aside|
              aside["class"] += " not-prose"
            end

            content_tag(
              :div,
              fragment.to_html.html_safe,
              class: "prose max-w-none"
            )
          RUBY
        ensure
          ActionView::Base.annotate_rendered_view_with_filenames = previous
        end
      end
    end
  end
end

ActionView::Template.register_template_handler(:md, ActionView::Template::Handlers::Markdown)
