
const drawPolygon = () => {
  const mapElement = document.getElementById('map-index');

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

    const selectPolygon = document.getElementById('rule_polygon_ids');
    selectPolygon.addEventListener('change', (event) => {
      console.log('Value changed');
      // Apagar/remover layers do leaflet;
      mapContainer.eachLayer(function(layer) {
        if (!!layer.toGeoJSON) {
          mapContainer.removeLayer(layer);
        }
      });
      const polygonsGroup = new L.FeatureGroup();
      // Capturing all current selected options
      let ids = [];
      let len = selectPolygon.options.length;
      for (var i = 0; i < len; i++) {
        let opt = selectPolygon.options[i];
        if (opt.selected) {
          ids.push(opt.value);
        }
      };
      // Fetch para buscar os polígonos pelos seus IDs;
      // to do: change the respective Polygons Controller action so as to pass a WKT (stringfied polygon)
      // this way is too slow for big complex polygons.
      fetch(`/polygons/[${ids}]`)
        .then(response => response.json())
        .then(json => JSON.parse(json.polygons))
        .then((data) => {
          Object.keys(data).forEach( key => {
            // instantiate a Wicket object. Wicket is a JS library that translates
            // Well Known Text into Leaflet layers.
            let wkt = new Wkt.Wkt();
            wkt.read(data[key]);
            let wktToLeafletObejct = wkt.toObject();
            polygonsGroup.addLayer(wktToLeafletObejct);
          });
          polygonsGroup.addTo(mapContainer);
          mapContainer.fitBounds(polygonsGroup.getBounds());
        });
    });
  };
};

export { drawPolygon }
