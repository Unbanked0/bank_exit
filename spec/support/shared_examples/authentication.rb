RSpec.shared_examples 'an authenticated endpoint' do
  context 'when credentials are invalid' do
    let(:headers) { basic_auth_headers(username: 'wrong', password: 'invalid') }

    before { action }

    it 'returns 401 Unauthorized' do
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when credentials are missing' do
    before do
      send(method, path, headers: headers.except(:Authorization))
    end

    it 'returns 401 Unauthorized' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
