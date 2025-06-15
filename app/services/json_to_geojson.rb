# This service is responsible to convert a JSON structured file
# from Overpass API to a GeoJSON that is better understandable
# by Leaflet map.
class JSONToGeoJSON < ApplicationService
  attr_reader :json

  def initialize(json)
    @json = json
  end

  def call
    geojson = {
      type: 'FeatureCollection',
      generator: "#{json['generator']} - Note: converted to GeoJSON by manual script",
      timestamp: json.dig('osm3s', 'timestamp_osm_base'),
      copyright: json.dig('osm3s', 'copyright'),
      features_count: elements.count,
      features: []
    }

    elements.each do |element|
      geometry = if element['geometry'].blank?
                   {
                     type: 'Point',
                     coordinates: [element['lon'], element['lat']]
                   }
                 else
                   coordinates = element['geometry'].map do |coord|
                     [coord['lon'], coord['lat']]
                   end

                   {
                     type: 'Polygon',
                     coordinates: [coordinates]
                   }
                 end

      geojson[:features] << {
        type: 'Feature',
        id: "#{element['type']}/#{element['id']}",
        properties: element['tags'],
        geometry: geometry
      }
    end

    geojson.deep_stringify_keys
  end

  private

  def elements
    json['elements']
  end
end
