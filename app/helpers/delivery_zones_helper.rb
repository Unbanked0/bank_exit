module DeliveryZonesHelper
  def french_departments_select_helper
    t('departments').map do |row|
      department_number = row[0].to_s.delete('FR-')
      ["#{row[1]} (#{department_number})", "#{row[0]} France"]
    end
  end

  def french_regions_select_helper
    t('regions').map do |row|
      [row[1], row[0]]
    end
  end

  def continents_select_helper
    t('continents').map do |row|
      [row[1], row[0]]
    end
  end
end
