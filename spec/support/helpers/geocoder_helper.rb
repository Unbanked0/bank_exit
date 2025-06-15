require 'json'

module GeocoderHelper
  FIXTURE_PATH = Rails.root.join('spec/fixtures/geocoder_stubs.yaml')

  def stub_geocoder_from_fixture!
    Geocoder::Lookup::Test.reset

    stubs = load_fixture_data

    stubs.each do |query, results|
      key = query_key(query)
      Geocoder::Lookup::Test.add_stub(key, results)
    end
  end

  private

  def load_fixture_data
    YAML.load_file(FIXTURE_PATH, aliases: true)
  end

  def query_key(query)
    if query.include?('[')
      JSON.parse(query)
    else
      query.to_s.strip
    end
  end
end
