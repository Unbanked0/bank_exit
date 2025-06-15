class ApplicationService
  include Mixin::Callable

  private

  def files_folder_prefix
    Rails.env.test? ? 'spec/fixtures/files' : 'storage'
  end
end
