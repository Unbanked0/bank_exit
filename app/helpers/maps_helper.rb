module MapsHelper
  def map_enabled_disabled_collection_values_for_select
    [
      [t('enabled'), true],
      [t('disabled'), false]
    ]
  end

  def map_attribution_html
    "#{image_tag('monero-map-logo.png', class: 'inline w-7 py-1')} #{URI(root_url).host}"
  end

  def embed_map_attribution_html
    link_to map_attribution_html, root_url, title: I18n.t('welcome.index.title')
  end
end
