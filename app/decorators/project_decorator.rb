class ProjectDecorator < ApplicationDecorator
  def website_screenshot?
    website_screenshot.present?
  end

  def iframe_url?
    iframe_url.present?
  end

  def github_url?
    github_url.present?
  end

  def grocery?
    identifier == 'grocery'
  end

  def external?
    external == true
  end

  def flyer?
    identifier == 'flyer'
  end

  def local_groups?
    identifier == 'local_groups'
  end

  def accounting?
    identifier == 'accounting'
  end

  def map?
    identifier == 'map'
  end

  def link
    controller, action = route.split('#')

    route = {
      controller: "/#{controller}",
      action: action,
      locale: I18n.locale.to_s
    }

    route[:id] = identifier unless map? || local_groups?
    route
  end
end
