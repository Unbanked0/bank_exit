module ModalsHelper
  def render_modal(**, &block)
    render('modal_template', **, &block)
  end
end
