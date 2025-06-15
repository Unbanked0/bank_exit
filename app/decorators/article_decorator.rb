class ArticleDecorator < ApplicationDecorator
  def highlight?
    highlight == true
  end

  def all_body
    contents.map(&:body).compact_blank.flatten
  end

  def missing_content_for_locale?
    missing_content_for_locale == true
  end
end
