
const drawPolygon = () => {
  const mapElement = document.getElementById('map-index');

  if (mapElement) {
    var mapContainer = L.map(mapElement).setView([-15.5, -48], 5);

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
      // Fetch para buscar os polígonos pelos seus IDs;
      // to do: change the respective Polygons Controller action so as to pass a WKT (stringfied polygon)
      // this way is too slow for big complex polygons.
      fetch(`/polygons/${selectPolygon.value}`)
        .then(response => console.log(response));
        return;
        // .then(response => JSON.parse(response.polygons))
        // .then((data) => {
        //   Object.keys(data).forEach( key => {
        //     // instantiate a Wicket object. Wicket is a JS library that translates
        //     // Well Known Text into Leaflet layers.
        //     let wkt = new Wkt.Wkt();
        //     wkt.read(jsonWkts[key]);
        //     let wktToLeafletObejct = wkt.toObject();
        //     polygonsGroup.addLayer(wktToLeafletObejct);
        //   });
        //   polygonsGroup.addTo(mapContainer);
        //   mapContainer.fitBounds(polygonsGroup.getBounds());
        // });
    });
  };
};

export { drawPolygon }
