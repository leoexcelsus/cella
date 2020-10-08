const showPolygon = () => {
  const mapElement = document.getElementById('map-show');

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

    // const selectedPolygon = document.getElementById('polygon-selected');
    // selectedPolygon.addEventListener('click', (event) => {
    //   console.log('Value changed');

      const drawnItems = new L.FeatureGroup();

      // Selecionar o objeto que contém o hash stringfied;
      // const id = document.querySelector("#polygons-list").dataset.polygonIds
      // Parseá-lo para JSON;

      // Iterar sobre o JSON para obter o array de arrays de coordenadas;
      // Inverter os pares de coordenadas;
      // e passar cada array para o leaflet montar uma camada;
      // const object = hash.forEach();
      const polygons = document.getElementById('all-polygons');
      const polygonsIds = polygons.dataset.polygons.split('-');

      polygonsIds.forEach((polygonId) => {
      fetch(`/polygons/${polygonId}`)
        .then(response => response.json())
        .then((data) => {
          let array = data.coordinates;
          let newArray = [];
          let i = 0;
          let buffer = 0;
          while (i < array.length) {
            buffer = array[i][0];
            array[i][0] = array[i][1];
            array[i][1] = buffer;
            newArray.push(array[i]);
            i = i + 1;
          };
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

      })
      // Recebe um hash ou um array de coordenadas (armazenadas em uma enumerable);
      // // Iterar sobre esse resultado para criar camadas do leaflet para visualização no mapa;
      // data.forEach((result) => {
      // função/módulo do leaflet => L.Polygon(array de pares de coordenadas).addTo(nome da variável que contém o mapa);
    // });
};
};
export { showPolygon }
