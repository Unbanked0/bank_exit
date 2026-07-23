class ProjectDecorator < ArticleDecorator
  def author?
    false
  end

  def level?
    false
  end

  def time?
    false
  end

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
