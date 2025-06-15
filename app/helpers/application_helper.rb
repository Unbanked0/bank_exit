module ApplicationHelper
  include Pagy::Frontend

  def render_turbo_stream_flash_messages
    turbo_stream.prepend 'flashes', partial: 'flashes'
  end

  def welcome_page?
    params[:controller] == 'welcome'
  end

  # :nocov:
  # Feature is disabled for now
  def last_short_commit_id
    last_long_commit_id.first(7)
  end

  def last_long_commit_id
    ENV.fetch('GIT_LAST_COMMIT_ID', `git rev-parse HEAD`)
  rescue StandardError
    'Error'
  end

  def deployed_branch
    ENV.fetch('GIT_DEPLOYED_BRANCH', `git branch --show-current`).strip
  rescue StandardError
    'Error'
  end
  # :nocov:

  def icon_for_category(category)
    MerchantIcon.call(category)
  end

  def select_options_for(klass, enum_name)
    enum = klass.send(enum_name)
    enum.keys.map { |k| [klass.human_enum_name(enum_name, k), k] }
  end

  def pretty_country_html(country, show_flag: false)
    c = ISO3166::Country[country]

    name = c.translations[I18n.locale.to_s] ||
           c.common_name || c.iso_short_name

    return name unless show_flag

    flag = c.emoji_flag
    "#{flag} #{name}"
  rescue StandardError
    country
  end

  def back_link_to(label, link, klass: '', data: {})
    link_to link, class: klass, data: data do
      concat lucide_icon('move-left', class: 'inline-flex mr-1')
      concat label
    end
  end

  def map_referer_path
    request.referer && request.referer != request.url ? request.referer : maps_path
  end

  def logo_by_locale
    if I18n.locale == :en
      'logo_EN.png'
    else
      'logo.png'
    end
  end
end
