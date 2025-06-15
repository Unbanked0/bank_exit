import { Application } from "@hotwired/stimulus";
import * as L from "leaflet";

const application = Application.start();

import MapEmbedController from "controllers/map/embed_controller";
import MapPopupController from "controllers/map/popup_controller";

application.register("map--embed", MapEmbedController);
application.register("map--popup", MapPopupController);

// Prevent scrolling to anchor on map actions (zoom)
L.Control.prototype._refocusOnMap = function _refocusOnMap() {};
