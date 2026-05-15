module ModalsHelper
  def render_modal(data: {}, **, &)
    modal_body_html = capture(&) if block_given?

    render(
      'application/modal',
      **,
      data: data,
      modal_body_html: modal_body_html
    )
  end
end
