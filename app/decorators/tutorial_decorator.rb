class TutorialDecorator < ArticleDecorator
  def author?
    author.present?
  end

  def level?
    model[:level].present?
  end

  def time
    @time ||= model[:time]
  end

  def time?
    time.present?
  end

  def might_be_outdated?
    return false unless created_at

    created_at.before?(2.years.ago)
  end
end
