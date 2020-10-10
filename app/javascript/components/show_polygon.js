const showPolygon = () => {
  const mapElement = document.getElementById('map-show');

  if (mapElement) {
    var mapContainer = L.map(mapElement, {zoomControl: false, scrollWheelZoom: false})
      .setView([-15.5, -48], 5)
      .setMaxBounds([[-38.7, -85.8],[11.7, -21.7]]);

    mapContainer.on('click', function() {
      if (mapContainer.scrollWheelZoom.enabled()) {
        mapContainer.scrollWheelZoom.disable();
      } else {
        mapContainer.scrollWheelZoom.enable();
      }
    });

    L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoibGVvZXhjZWxzdXMiLCJhIjoiY2tleWNxcnB2MGFzejJwcXQwdGIwMmR2byJ9.CbC1R_EI0AICNAxaZSvyeg', {
      attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
      maxZoom: 18,
      id: 'mapbox/streets-v11',
      tileSize: 512,
      zoomOffset: -1,
      accessToken: 'pk.eyJ1IjoibGVvZXhjZWxzdXMiLCJhIjoiY2tleWNxcnB2MGFzejJwcXQwdGIwMmR2byJ9.CbC1R_EI0AICNAxaZSvyeg'
    }).addTo(mapContainer);
    const polygonWkt = document.querySelector("#all-polygons").dataset["wkt"];
    // instantiate a Wicket object. Wicket is a JS library that translates Well Known Text
    // into Leaflet layers.
    var wkt = new Wkt.Wkt();
    wkt.read(polygonWkt);
    const wktToLeafletObejct = wkt.toObject();
    wktToLeafletObejct.addTo(mapContainer);
    mapContainer.fitBounds(wktToLeafletObejct.getBounds());
  };
};
export { showPolygon }
