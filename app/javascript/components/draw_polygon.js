
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
      const drawnItems = new L.FeatureGroup();
      // Fetch para buscar os polígonos pelos seus IDs;
      // to do: change the respective Polygons Controller action so as to pass a WKT (stringfied polygon)
      // this way is too slow for big complex polygons.
      fetch(`/polygons/${selectPolygon.value}`)
        .then(response => response.json())
        .then((data) => {
          // console.log(data.coordinates);
          let array = data.coordinates;
          let newArray = [];
          let i = 0;
          let buffer = 0;
          while (i < array.length) {
            buffer = array[i][0];
            array[i][0] = array[i][1];
            array[i][1] = buffer;
            // console.log(array[i]);
            newArray.push(array[i]);
            i = i + 1;
          };
          // console.log(newArray)
          // data é um JSON com uma chave coordinates;
          // dentro dessa chave coordinates, temos um array de arrays com as coordenadas;
          // precisamos enviar esses dados para o mapa e atualizá-lo;
          L.polygon(data.coordinates,
            {
              color: '#000',
              weight: 1,
              fillColor: '#6E8B3D',
              fillOpacity: 0.5,
            }).addTo(mapContainer);
          // TO DO: data.coordinates has many coordinate pairs;
          // Is this the right way?
          mapContainer.fitBounds(data.coordinates);
        });
      // Recebe um hash ou um array de coordenadas (armazenadas em uma enumerable);
      // // Iterar sobre esse resultado para criar camadas do leaflet para visualização no mapa;
      // data.forEach((result) => {
      // função/módulo do leaflet => L.Polygon(array de pares de coordenadas).addTo(nome da variável que contém o mapa);
    });
  };
};

export { drawPolygon }
