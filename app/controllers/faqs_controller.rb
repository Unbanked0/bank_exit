class FAQsController < ApplicationController
  # @route GET /fr/faq {locale: "fr"} (faq_fr)
  # @route GET /es/faq {locale: "es"} (faq_es)
  # @route GET /en/faq {locale: "en"} (faq_en)
  # @route GET /faq
  def show
    @faqs = FAQ.all
  end
end
