RSpec.shared_context 'with user role' do |role|
  let(:current_user) { create :user, role: role }

  before { sign_in_as current_user }

  after { sign_out }
end

RSpec.shared_context 'without login' do
  let(:current_user) { nil }
end

RSpec.shared_examples 'access denied' do
  it 'denies access', :aggregate_failures do
    subject

    main_url_helpers = Rails.application.routes.url_helpers

    expect(response).to redirect_to main_url_helpers.root_path
    expect(flash[:alert]).to eq 'You do not have permission to access this page'
  end
end

RSpec.shared_examples 'access unauthenticated' do
  it 'denies access', :aggregate_failures do
    subject

    main_url_helpers = Rails.application.routes.url_helpers

    expect(response).to redirect_to main_url_helpers.new_session_path
    expect(flash[:alert]).to eq I18n.t('pundit.not_authenticated')
  end
end

RSpec.shared_examples 'access granted' do
  it 'allows access' do
    subject
    expect(response).to have_http_status(:ok)
  end
end

RSpec.shared_examples 'access granted with redirection' do
  it 'allows access', :aggregate_failures do
    subject

    expect(response).to redirect_to redirection_url
    expect(flash[:notice]).to eq(flash_notice) if defined?(flash_notice)
  end
end
