class FAQsController < ApplicationController
  # @route GET /fr/foire-aux-questions {locale: "fr"} (faq_fr)
  # @route GET /es/preguntas-mas-frecuentes {locale: "es"} (faq_es)
  # @route GET /en/frequently-asked-questions {locale: "en"} (faq_en)
  # @route GET /faq
  def show
    @faqs = FAQ.all
  end
end
