// import "leaflet";
// import 'leaflet-draw';

// require("leaflet/dist/leaflet.css");
// require("leaflet-draw/dist/leaflet.draw.css");


const mapDrawInit = () => {
  console.log("Hello from map_draw_init function!!")
};


  const mapElement = document.getElementById('map');

  if (mapElement) {
    var map = L.map(mapElement).setView([-15.5, -48], 5);

    L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}', {
      attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
      maxZoom: 18,
      id: 'mapbox/streets-v11',
      tileSize: 512,
      zoomOffset: -1,
      accessToken: 'pk.eyJ1IjoibGVvZXhjZWxzdXMiLCJhIjoiY2tleWNxcnB2MGFzejJwcXQwdGIwMmR2byJ9.CbC1R_EI0AICNAxaZSvyeg'
    }).addTo(map);

    var drawnItems = new L.FeatureGroup();

    map.addLayer(drawnItems);

    var drawControl = new L.Control.Draw({
         edit: {
             featureGroup: drawnItems
         },
         draw: {
          marker: false,
          circle: false,
          circlemarker: false,
          rectangle: false,
          polygon: false,
          polyline: false
         }
     });

    // funcao para transformar uma leaflet layer em string no formato Well Known Text.
    // é preciso ter atenção ao nome da variável que contém L.map nessa funcao.
    function toWKT (layer) {
      var lng, lat, coords = [];
      if (layer instanceof L.Polygon || layer instanceof L.Polyline) {
        var latlngs = layer.getLatLngs();
        for (var i = 0; i < latlngs.length; i++) {
          var latlngs1 = latlngs[i];
          if (latlngs1.length){
            for (var j = 0; j < latlngs1.length; j++) {
              coords.push(latlngs1[j].lng + " " + latlngs1[j].lat);
              if (j === 0) {
              lng = latlngs1[j].lng;
              lat = latlngs1[j].lat;
              }
            }
          } else {
            coords.push(latlngs[i].lng + " " + latlngs[i].lat);
            if (i === 0) {
              lng = latlngs[i].lng;
              lat = latlngs[i].lat;
            }
          }
        };
        if (layer instanceof L.Polygon) {
          return "POLYGON((" + coords.join(",") + "," + lng + " " + lat + "))";
        } else if (layer instanceof L.Polyline) {
          return "LINESTRING(" + coords.join(",") + ")";
        }
      } else if (layer instanceof L.Marker) {
        return "POINT(" + layer.getLatLng().lng + " " + layer.getLatLng().lat + ")";
      }
    };

    //evento para aplicar a funcao toWKT à última layer editadas
    map.on('draw:edited', function (e) {
      e.layers.eachLayer(function(layer) {
          const wktContainer = document.getElementById('wkt-hidden-input');
          wktContainer.value = toWKT(layer);
          console.log(wktContainer.value);
        });
    });

    //evento para aplicar a funcao toWKT à última layer criada
    map.on('draw:created', function (e) {
      var layer = e.layer;
      drawnItems.addLayer(layer);
      const wktContainer = document.getElementById('wkt-hidden-input');
      wktContainer.value = toWKT(layer);
      console.log(`Form input keeps only this geometry:\n${wktContainer.value}`);
      });

  }


    window.addEventListener("load", (event) => {
      document.getElementById('form-3th-row').hidden = true;
      document.getElementById('form-4th-row').hidden = true;
    });
    const formGeoInputOption = document.getElementById('geom-input-option');
    formGeoInputOption.addEventListener('input', (event) => {
      console.log("Geometry input option is set");
      const form3thRow = document.getElementById('form-3th-row');
      const form4thRow = document.getElementById('form-4th-row');
      if (formGeoInputOption.value == "draw") {
        form3thRow.hidden = false;
        form4thRow.hidden = true;
      } else if (formGeoInputOption.value == "upload") {
        form3thRow.hidden = true;
        form4thRow.hidden = false;
        drawControl.remove(map);
      } else {
        form3thRow.hidden = true;
        form4thRow.hidden = true;
        drawControl.remove(map);
      };
    });

    const formShapeOption = document.getElementById('shape-option');
    formShapeOption.addEventListener('input', (event) => {
      console.log("Geomerty type was selected");
      if (formShapeOption.value == "polygon") {
        drawControl._toolbars.draw.options.polyline = false;
        drawControl._toolbars.draw.options.polygon = true;
        map.addControl(drawControl);
      } else if (formShapeOption.value == "polyline") {
        drawControl._toolbars.draw.options.polyline = true;
        drawControl._toolbars.draw.options.polygon = false;
        map.addControl(drawControl);
      } else {
        drawControl._toolbars.draw.options.polyline = false;
        drawControl._toolbars.draw.options.polygon = false;
        drawControl.remove(map);
      };
    });


console.log("Hello from map_draw_init file!!")

 export { mapDrawInit };
