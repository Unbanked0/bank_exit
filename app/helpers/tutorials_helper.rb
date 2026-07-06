module TutorialsHelper
  def tutorial_class_by_level(level)
    case level.to_sym
    when :beginner then 'badge-success'
    when :intermediate then 'badge-warning'
    when :expert then 'badge-error'
    else
      'badge-neutral'
    end
  end
end
