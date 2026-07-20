class ArticleDecorator < ApplicationDecorator
  def missing_content_for_locale?
    missing_content_for_locale == true
  end
end
