class ArticleDecorator < ApplicationDecorator
  def missing_content_for_locale?
    missing_content_for_locale == true
  end

  def author?
    author.present?
  end

  def level?
    level.present?
  end

  def time?
    time.present?
  end

  def created_at?
    created_at.present?
  end
end
