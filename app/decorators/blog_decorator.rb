class BlogDecorator < ArticleDecorator
  def author?
    false
  end

  def level?
    false
  end

  def time?
    false
  end
end
