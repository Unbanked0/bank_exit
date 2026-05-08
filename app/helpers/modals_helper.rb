module ModalsHelper
  def render_modal(data: {}, **, &block)
    modal_body_html = capture(&block) if block_given?

    render(
      'application/modal',
      **,
      data: data,
      modal_body_html: modal_body_html
    )
  end
end
