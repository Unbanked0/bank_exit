# Pin npm packages by running ./bin/importmap

pin 'application', preload: :application
pin 'map_embed', preload: :map_embed

pin '@hotwired/turbo-rails', to: 'turbo.min.js'
pin '@hotwired/stimulus', to: 'stimulus.min.js'
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js'

pin_all_from 'app/javascript/controllers', under: 'controllers', preload: :application

pin '@rails/request.js', to: 'https://ga.jspm.io/npm:@rails/request.js@0.0.13/src/index.js'

pin 'stimulus-use', to: 'https://ga.jspm.io/npm:stimulus-use@0.53.0/dist/index.js', preload: :application

pin 'leaflet', to: 'https://ga.jspm.io/npm:leaflet@2.0.0-alpha.1/dist/leaflet.js'
pin 'leaflet-v1-polyfill'
pin 'leaflet-gesture-handling', to: 'https://ga.jspm.io/npm:leaflet-gesture-handling@1.2.2/dist/leaflet-gesture-handling.min.js'
pin 'leaflet.markercluster', to: 'https://ga.jspm.io/npm:@kristjan.esperanto/leaflet.markercluster@3.0.0/dist/leaflet.markercluster.js'
pin 'leaflet.fullscreen', to: 'https://ga.jspm.io/npm:leaflet.fullscreen@5.3.1/dist/Control.FullScreen.js'
pin 'polyline-encoded', to: 'https://ga.jspm.io/npm:polyline-encoded@0.0.9/Polyline.encoded.js', preload: :application

pin 'chartkick', to: 'chartkick.js', preload: :application
pin 'Chart.bundle', to: 'Chart.bundle.js', preload: :application

pin 'sortablejs', to: 'https://ga.jspm.io/npm:sortablejs@1.15.7/modular/sortable.core.esm.js'
