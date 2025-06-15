import MapBaseController from "controllers/map_base_controller";

export default class MapItemController extends MapBaseController {
  static values = {
    merchant: { type: Object },
    marker: { type: String },
  };

  connect() {
    super.connect();
    super._initMap();

    this.marker = L.marker(
      [this.merchantValue.latitude, this.merchantValue.longitude],
      {
        icon: this.assignMarker(this.merchantValue.icon),
        merchant: this.merchantValue,
      },
    );

    this.marker.on("click", this.loadPopupContent.bind(this));
    this.marker.addTo(this.map);

    this.marker.fire("click");
    this.map.fitBounds([this.marker.getLatLng()], { maxZoom: 15 });
  }
}
