RSpec.configure do |config|
  config.before(:suite) do
    Geocoder.configure(lookup: :test, ip_lookup: :test)
  end
end

# Monkey patch to add missing keys
module Geocoder
  module Result
    class Test < Base
      def town
        data['town']
      end

      def coordinates
        [data['latitude'].to_f, data['longitude'].to_f]
      end
    end
  end
end
