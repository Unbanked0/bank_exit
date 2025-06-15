RSpec.configure do |_config|
  def stub_overpass_request_success
    stub_request(:get, /overpass-api.de/)
      .with(query: hash_including(:data))
      .to_return_json(
        body: File.read('spec/fixtures/files/overpass_api_response.json')
      )
  end

  def stub_overpass_request_failure
    stub_request(:get, /overpass-api.de/)
      .to_raise('Overpass Exception !')
  end
end
