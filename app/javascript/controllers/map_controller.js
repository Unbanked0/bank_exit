import MapBaseController from "controllers/map_base_controller";
import "leaflet.markercluster";
import { patch } from "@rails/request.js";
import { useIntersection } from "stimulus-use";

export default class MapController extends MapBaseController {
  static values = {
    markers: { type: Array, default: [] },
    trackGeolocationInUrl: { type: Boolean, default: true },
    fitBounds: { type: Boolean, default: false },
    refererUrl: String,
  };

  connect() {
    const [_, unobserve] = useIntersection(this);
    this.unobserve = unobserve;
  }

  appear() {
    super.connect();

    this.mapOptions["gestureHandling"] = this.#forceGestureHandling();

    super._initMap();
    this.unobserve();

    if (this.markersValue.length == 0) {
      return;
    }

    this.bitcoinMarkers = L.markerClusterGroup({
      spiderfyOnMaxZoom: true,
      showCoverageOnHover: false,
      zoomToBoundsOnClick: true,
      chunkedLoading: true,
    });

    this.otherMarkers = L.markerClusterGroup({
      spiderfyOnMaxZoom: true,
      showCoverageOnHover: false,
      zoomToBoundsOnClick: true,
      maxClusterRadius: 40,
    });

    this.markersValue.forEach((item) => {
      const marker = L.marker([item.latitude, item.longitude], {
        icon: this.assignMarker(item.icon),
        merchant: item,
      });

      marker.on("click", this.loadPopupContent.bind(this));

      if (this.#isBitcoinOnly(item)) {
        this.bitcoinMarkers.addLayer(marker);
      } else {
        this.otherMarkers.addLayer(marker);
      }
    });

    this.map.addLayer(this.bitcoinMarkers);
    this.map.addLayer(this.otherMarkers);

    if (this.#forceFitBounds()) {
      const bounds = L.latLngBounds(this.bitcoinMarkers.getBounds());
      bounds.extend(this.otherMarkers.getBounds());

      this.map.fitBounds(bounds, { maxZoom: 14 });
    }

    if (this.trackGeolocationInUrlValue) {
      this.map.on("zoomend", (_) => {
        const newZoom = this.map.getZoom();
        let current = new URL(window.location.href);

        const newPathname = this.#buildNewPathnameForZoom(current, newZoom);

        if (newPathname !== undefined) {
          current.pathname = newPathname;
          window.history.pushState("id", "", current);

          // Update merchants filter form action
          document.getElementById("merchants_filter").action = current.pathname;

          this.#updateReferUrl(current.href);
        }
      });

      this.map.on("moveend", (e) => {
        const coordinates = e.target.getBounds().getCenter();
        let current = new URL(window.location.href);

        const newPathname = this.#buildNewPathnameForLatlon(
          current,
          coordinates.lat,
          coordinates.lng,
        );

        if (newPathname !== undefined) {
          current.pathname = newPathname;
          window.history.pushState("id", "", current);

          // Update merchants filter form action
          document.getElementById("merchants_filter").action = current.pathname;

          this.#updateReferUrl(current.href);
        }
      });
    }
  }

  disconnect() {
    if (this.bitcoinMarkers) {
      this.bitcoinMarkers.clearLayers();
    }
    if (this.other) {
      this.otherMarkers.clearLayers();
    }

    super.disconnect();
  }

  refreshMap() {
    this.disconnect();
    this.appear();
  }

  #buildNewPathnameForZoom(current, newZoom) {
    const pathSplit = current.pathname.split("/");

    // No locale present
    if (pathSplit.length == 5) {
      let [_, action, _oldZoom, latitude, longitude] = pathSplit;

      return [action, newZoom, latitude, longitude].join("/");
    }
    // Locale present
    else if (pathSplit.length == 6) {
      let [_, locale, action, oldZoom, latitude, longitude] = pathSplit;

      return [locale, action, newZoom, latitude, longitude].join("/");
    }
  }

  #buildNewPathnameForLatlon(current, newLatitude, newLongitude) {
    const pathSplit = current.pathname.split("/");

    // No locale present
    if (pathSplit.length == 5) {
      let [_, action, zoom, _oldLatitude, _oldLongitude] = pathSplit;

      return [action, zoom, newLatitude, newLongitude].join("/");
    }
    // Locale present
    else if (pathSplit.length == 6) {
      let [_, locale, action, zoom, _oldLatitude, _oldLongitude] = pathSplit;

      return [locale, action, zoom, newLatitude, newLongitude].join("/");
    }
  }

  #updateReferUrl(value) {
    patch(this.refererUrlValue, {
      body: {
        map_referer_url: value,
      },
    });
  }

  #isBitcoinOnly(item) {
    if (item.coins.includes("monero") || item.coins.includes("june")) {
      return false;
    }

    return true;
  }

  #forceFitBounds() {
    return (
      this.fitBoundsValue || localStorage.getItem("force-fit-bounds") == "true"
    );
  }

  #forceGestureHandling() {
    return localStorage.getItem("force-gesture-handling") == "true";
  }
}
