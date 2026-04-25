class DirectoryFriendDecorator < ApplicationDecorator
  def name
    value = object.name

    return value unless value.include?('I18n/')

    i18n = value.split('I18n/').last

    if i18n.starts_with?('model/')
      model = i18n.split('model/').last
      model.constantize.model_name.human.capitalize
    else
      I18n.t(i18n)
    end
  rescue StandardError
    object.name
  end

  def link
    value = object.link
    return value unless value.include?('#')

    controller, action = value.split('#')

    {
      controller: "/#{controller}",
      action: action,
      locale: I18n.locale.to_s
    }
  end

  def icon?
    icon.present?
  end

  def image?
    image.present?
  end

  def svg_image?
    svg_image.present?
  end
end
