class EmailAsTextFile < ApplicationService
  attr_reader :mailer, :assigns

  def initialize(mailer, assigns = {})
    @mailer = mailer
    @assigns = assigns
  end

  def call
    namespace, template = mailer.split('/')

    output_folder = "#{files_folder_prefix}/#{namespace}"
    FileUtils.mkdir_p(output_folder)

    File.write(
      "#{output_folder}/#{Time.current.to_fs(:number)}_#{template}.txt",
      ActionView::Base.full_sanitizer.sanitize(inline_template)
    )
  end

  private

  def inline_template
    ApplicationController.render(
      mailer, layout: false, formats: :text, assigns: assigns
    )
  end
end
