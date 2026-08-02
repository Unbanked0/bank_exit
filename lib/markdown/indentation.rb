module Markdown
  module Indentation
    LIST_OR_FENCE = /^\s*(?:[-*+]\s|\d+\.\s|```)/
    HTML_TAG = /^\s*</

    def self.normalize(markdown)
      markdown.to_s.lines.map do |line|
        if line.match?(HTML_TAG) && !line.match?(LIST_OR_FENCE)
          line.sub(/^ {2,}/, '')
        else
          line
        end
      end.join
    end
  end
end
