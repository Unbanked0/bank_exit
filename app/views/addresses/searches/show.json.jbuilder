json.array! @results do |result|
  case @lookup
  when :nominatim
    json.value result
    json.text result
  when :ban_data_gouv_fr
    json.value result['properties']['label']
    json.text result['properties']['label']
  end
end
