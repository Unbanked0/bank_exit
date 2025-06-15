class ExtractCategory < ApplicationService
  attr_reader :properties

  def initialize(properties)
    @properties = properties
  end

  def call
    category = properties['healthcare:speciality'].presence ||
               properties['healthcare'].presence ||
               properties['amenity'].presence ||
               properties['amenity_1'].presence ||
               properties['amenity_2'].presence ||
               properties['craft'].presence ||
               properties['office'].presence ||
               properties['sport'].presence ||
               properties['shop'].presence ||
               properties['tourism'].presence ||
               properties['leisure'].presence

    return if category.blank?

    # Some merchants have multiple categories. Only keep first
    category = category.split(';').first
                       .split(',').first

    # Last tweaks to merge different categories id
    # representing same meaning.
    case category
    when 'doctors', 'general' then 'doctor'
    when 'convenience' then 'grocery'
    when 'coffee' then 'cafe'
    when 'bureau_de_change' then 'exchange'
    when 'hostel' then 'hotel'
    when 'attraction' then 'theme_park'
    when 'magnétiseur' then 'magnetizer'
    when 'informatique' then 'it'
    when 'jeweller' then 'jewelry'
    when 'soccer' then 'football'
    when 'surfing', 'kitesurfing' then 'surf'
    when 'dentista', 'paediatric_dentistry', 'professional_tooth_cleaning' then 'dentist'
    when 'musical_instrument' then 'music'
    when 'travel_agent' then 'travel_agency'
    when 'coworking' then 'coworking_space'
    when '10pin' then 'bowling'
    when 'educational_institution' then 'school'
    when 'online_shop', 'onlineshop', 'marketplace' then 'online_store'
    when 'liquid laundry detergent' then 'laundry'
    when 'physiotherapie_praxis' then 'physiotherapy'
    when 'reparaciónes de moviles y tablet' then 'mobile_phone'
    when 'papeleria' then 'stationery'
    when 'smoking' then 'tobacco'
    when 'interior_design' then 'interior_decoration'
    when 'graphic_design' then 'web_design'
    when 'flash_frozen_healthy_food' then 'frozen_food'
    when 'financial' then 'financial_advisor'
    when 'engineering' then 'engineer'
    when 'stickerei' then 'embroiderer'
    when 'cosmetic_skincare' then 'cosmetic'
    when 'paint' then 'painter'
    else
      category
    end
  end
end
