module Markdown
  module Options
    VALUE = {
      parse: {
        smart: true
      },
      extension: {
        autolink: true,
        table: true,
        strikethrough: true,
        tasklist: true,
        alerts: true,
        header_ids: '',
        tagfilter: false
      },
      render: {
        unsafe: true,
        hardbreaks: false,
        alert_style: 'semantic'
      }
    }.freeze
  end
end
