require Rails.root.join('lib/markdown/handler')

ActionView::Template.register_template_handler(
  :md,
  Markdown::Handler
)
