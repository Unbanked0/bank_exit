require 'commonmarker'
require 'markdown/options'
require 'markdown/indentation'
require 'markdown/post_processor'

module Markdown
  class Handler
    class << self
      def call(template, source)
        erb_handler = ActionView::Template.registered_template_handler(:erb)

        previous =
          ActionView::Base.annotate_rendered_view_with_filenames

        begin
          ActionView::Base.annotate_rendered_view_with_filenames = false

          erb_source = erb_handler.call(template, source)

          <<~RUBY
            markdown = begin
              #{erb_source}
            end

            markdown = Markdown::Indentation.normalize(markdown)

            html = Commonmarker.to_html(
              markdown.to_s,
              options: Markdown::Options::VALUE
            )

            fragment = Nokogiri::HTML::DocumentFragment.parse(html)

            Markdown::PostProcessor.call(fragment)

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
