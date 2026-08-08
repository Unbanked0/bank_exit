class ProjectDecorator < ArticleDecorator
  def grocery?
    identifier == 'grocery'
  end
end
