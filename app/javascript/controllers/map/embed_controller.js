import MapBaseController from "controllers/map_base_controller";
import "leaflet.markercluster";

export default class MapEmbedController extends MapBaseController {
  static values = {
    markers: { type: Array, default: [] },
    gestureHandling: { type: Boolean, default: true },
    fitBounds: { type: Boolean, default: true },
    useClusters: { type: Boolean, default: true },
  };

  connect() {
    super.connect();

    this.mapOptions["gestureHandling"] = this.gestureHandlingValue;

    super._initMap();

    if (this.showAttributionValue) {
      this.map.attributionControl.addAttribution(
        `${this.markersValue.length} 📍`,
      );
    }

    if (this.markersValue.length == 0) {
      return;
    }

    if (this.useClustersValue) {
      this.markers = L.markerClusterGroup({
        spiderfyOnMaxZoom: true,
        showCoverageOnHover: false,
        zoomToBoundsOnClick: true,
        chunkedLoading: true,
      });
    } else {
      this.markers = L.featureGroup();
    }

    this.markersValue.forEach((item) => {
      const marker = L.marker([item.latitude, item.longitude], {
        icon: this.assignMarker(item.icon),
        merchant: item,
      });

      marker.on("click", this.loadPopupContent.bind(this));

      this.markers.addLayer(marker);
    });

    this.map.addLayer(this.markers);

    if (this.fitBoundsValue) {
      this.map.fitBounds(this.markers.getBounds(), {
        maxZoom: 15,
      });
    }
  }

  disconnect() {
    this.markers.clearLayers();

    super.disconnect();
  }
}
