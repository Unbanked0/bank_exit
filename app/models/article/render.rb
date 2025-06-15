class Article
  class Render
    attr_reader :partial, :template, :pdf, :caption

    def initialize(partial: nil, template: nil, pdf: nil, caption: nil)
      @partial = partial
      @template = template
      @pdf = pdf
      @caption = caption
    end

    def partial?
      partial.present?
    end

    def template?
      template.present?
    end

    def pdf?
      pdf.present?
    end

    def caption?
      caption.present?
    end
  end
end
