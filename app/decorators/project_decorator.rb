class ProjectDecorator < ArticleDecorator
  def grocery?
    identifier == 'grocery'
  end

  def local_groups?
    identifier == 'local_groups'
  end

  def accounting?
    identifier == 'accounting'
  end
end
