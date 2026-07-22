module AnnouncementsHelper
  def announcement_alert_type(mode)
    case mode
    when 'success' then 'alert-success'
    when 'info' then 'alert-info'
    when 'warning' then 'alert-warning'
    when 'error' then 'alert-error'
    else
      ''
    end
  end

  def announcement_color_by_mode(mode)
    case mode
    when 'success' then 'badge-success'
    when 'info' then 'badge-info'
    when 'warning' then 'badge-warning'
    when 'error' then 'badge-error'
    else
      ''
    end
  end
end
