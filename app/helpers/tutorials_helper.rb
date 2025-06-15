module TutorialsHelper
  def tutorial_class_by_level(level)
    case level.to_sym
    when :beginner then :success
    when :intermediate then :warning
    when :expert then :error
    else
      :neutral
    end
  end
end
