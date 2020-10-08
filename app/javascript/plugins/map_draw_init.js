const mapDrawInit = () => {
  console.log("Hello from map_draw_init function!!")
};
// Instantiate a Leaflet map if there is a div element whose id='map'
const mapElement = document.getElementById('map');
if (mapElement) {
  var map = L.map(mapElement).setView([-15.5, -48], 2.7).setMaxBounds([[-38.7, -85.8],[11.7, -21.7]]);
  L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}', {
    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
    maxZoom: 18,
    id: 'mapbox/streets-v11',
    tileSize: 512,
    zoomOffset: -1,
    accessToken: 'pk.eyJ1IjoibGVvZXhjZWxzdXMiLCJhIjoiY2tleWNxcnB2MGFzejJwcXQwdGIwMmR2byJ9.CbC1R_EI0AICNAxaZSvyeg'
  }).addTo(map);
  // Creates an empty layer group
  var drawnItems = new L.FeatureGroup();
  // Adds empty layer group to variable 'map'
  map.addLayer(drawnItems);
  // Creates a controller for the drawings, but not added to map yet.
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
  // geometry container
  var wktContainer = document.getElementById('wkt-hidden-input');
  // changes form according to user's decision: file upload or drawing?
  const formGeoInputOption = document.getElementById('search_geom_input_option');
  formGeoInputOption.addEventListener('input', (event) => {
    console.log("Geometry input option is set");
    const drawingToolSelector = document.getElementById('form-3th-row');
    const upLoadButton = document.getElementById('form-4th-row');
    if (formGeoInputOption.value == "draw") {
      drawingToolSelector.hidden = false;
      upLoadButton.hidden = true;
    } else if (formGeoInputOption.value == "upload") {
      if (wktContainer.value == "") {
        drawingToolSelector.hidden = true;
        upLoadButton.hidden = false;
      } else {
        window.alert("Você deve apagar o desenho feito sobre o mapa para poder carregar um arquivo shapefile.")
      }
    } else {
      drawingToolSelector.hidden = true;
      upLoadButton.hidden = true;
    };
  });
  // Enables drawing tool according to input given by the user in the Form
  const formShapeOption = document.querySelector("#search_shape_option");
  formShapeOption.addEventListener('input', (event) => {
    console.log("Geomerty type was selected");
    if (formShapeOption.value == "polygon") {
      // Prevents user from adding another layer
      if (Object.keys(drawnItems._layers).length == 0) {
        window.alert("Desenhe sua área clicando sobre o mapa.");
        map.addControl(drawControl);
        new L.Draw.Polygon(map, drawControl.options.polygon).enable();
      }
    } else if (formShapeOption.value == "polyline") {
      // Prevents user from adding another layer
      if (Object.keys(drawnItems._layers).length == 0) {
        window.alert("Desenhe sua linha clicando sobre o mapa.");
        map.addControl(drawControl);
        new L.Draw.Polyline(map, drawControl.options.polyline).enable();
      }
    } else {
    };
  });
  // Event definition to update an edited drawing into the hidden form
  // field for the geometry
  map.on('draw:edited', function (e) {
    e.layers.eachLayer(function(layer) {
        wktContainer.value = toWKT(layer);
        map.fitBounds(layer.getBounds());
        console.log(`Form input keeps only this geometry:\n${wktContainer.value}`);
      });
  });
  // Event defintion that saves drawing in Well Known Text format
  // into the hidden form fiel for the geometry
  map.on('draw:created', function (e) {
    var layer = e.layer;
    if (Object.keys(drawnItems._layers).length == 0) {
      drawnItems.addLayer(layer);
      formShapeOption.value = "";
      wktContainer.value = toWKT(layer);
      map.fitBounds(layer.getBounds());
      window.alert("Desenho georreferenciado adicionado ao formulário.");
      geometryReady = true;
      if (industry.value !==  "") {
        buttonDiv.hidden = false;
      };
      console.log(`Form input keeps only this geometry:\n${wktContainer.value}`);
    } else {
      window.alert("Você está tentando acrescentar um novo polígono ou uma nova "
      + "linha. Esta pesquisa aceita somente uma linha ou um polígono por busca.");
    }
  });
  // Function definition to change a Leaflet Layer to the Well Known Text format.
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
  // Translates some of the tooltips into Portuguese. Must keep all the keys of this object.
  L.drawLocal = {
    // format: {
    //  numeric: {
    //    delimiters: {
    //      thousands: ',',
    //      decimal: '.'
    //    }
    //  }
    // },
    draw: {
      toolbar: {
        // #TODO: this should be reorganized where actions are nested in actions
        // ex: actions.undo  or actions.cancel
        actions: {
          title: 'Cancelar desenho',
          text: 'Cancelar'
        },
        finish: {
          title: 'Terminar desenho',
          text: 'Terminar'
        },
        undo: {
          title: 'Delete last point drawn',
          text: 'Delete last point'
        },
        buttons: {
          polyline: 'Draw a polyline',
          polygon: 'Draw a polygon',
          rectangle: 'Draw a rectangle',
          circle: 'Draw a circle',
          marker: 'Draw a marker',
          circlemarker: 'Draw a circlemarker'
        }
      },
      handlers: {
        circle: {
          tooltip: {
            start: 'Click and drag to draw circle.'
          },
          radius: 'Radius'
        },
        circlemarker: {
          tooltip: {
            start: 'Click map to place circle marker.'
          }
        },
        marker: {
          tooltip: {
            start: 'Click map to place marker.'
          }
        },
        polygon: {
          tooltip: {
            start: 'Clique para iniciar o desenho da forma.',
            cont: 'Clique para continuar desenhando a forma.',
            end: 'Clique no primeiro ponto inserido para finaliza a forma.'
          }
        },
        polyline: {
          error: '<strong>Erro:</strong> as bordas da forma não podem se cruzar!',
          tooltip: {
            start: 'Clique para começar a desenhar a linha.',
            cont: 'Clique para continuar desenhando.',
            end: 'Clique novamente no último ponto inserido para finalizar a linha.'
          }
        },
        rectangle: {
          tooltip: {
            start: 'Click and drag to draw rectangle.'
          }
        },
        simpleshape: {
          tooltip: {
            end: 'Release mouse to finish drawing.'
          }
        }
      }
    },
    edit: {
      toolbar: {
        actions: {
          save: {
            title: 'Salvar alterações',
            text: 'Salvar'
          },
          cancel: {
            title: 'Cancelar edição e descartar alterações',
            text: 'Cancelar'
          },
          clearAll: {
            title: 'Clear all layers',
            text: 'Limpar tudo'
          }
        },
        buttons: {
          edit: 'Editar desenho',
          editDisabled: 'Sem desenho para editar',
          remove: 'Apagar desenho',
          removeDisabled: 'Sem desenho para apagar'
        }
      },
      handlers: {
        edit: {
          tooltip: {
            text: 'Arraste os vértices para alterar a forma.',
            subtext: 'Clique cancelar para desfazer as alterações.'
          }
        },
        remove: {
          tooltip: {
            text: 'Clique na forma para removê-la.'
          }
        }
      }
    }
  };
  // Controls submit button availability
  let industryReady = false;
  let geometryReady = false;
  var industry = document.querySelector("#search_industry");
  var geometry = document.querySelector("#wkt-hidden-input");
  const buttonDiv = document.getElementById('spatial-search-form-button');
  industry.addEventListener("change", (event) => {
    console.log(`an industry event has taken place: Before: industryReady = ${industryReady}`);
    if (industry.value !==  "" && geometryReady == true) {
      buttonDiv.hidden = false;
    } else if (industry.value !==  "" && geometryReady == false) {
      industryReady = true;
    } else {
      industryReady = false;
      buttonDiv.hidden = true;
    }
    console.log(`an industry event has taken place: Afterwards: industryReady = ${industryReady}`);
  });
  map.on('draw:deleted', function (e) {
    wktContainer.value = "";
    geometryReady = false;
    buttonDiv.hidden = true;
  });
  // importing user's loaded shapefile as a Leaflet layer
  let  shpFormField = document.querySelector("#search_shapefile");
  shpFormField.addEventListener('change', e => {
    console.log("File upload event");
    var files = shpFormField.files;
    if (files.length == 0) {
      return; //do nothing if no file given yet
    }
    var file = files[0];
    if (file.name.slice(-3) != 'zip'){ //Demo only tested for .zip. All others, return.
      window.alert('Selecione um aquivo .zip');
      return;
    } else {
      handleZipFile(file);
    }
  });
  //More info: httsp://developer.mozilla.org/en-US/docs/Web/API/FileReader
  function handleZipFile(file){
    var reader = new FileReader();
    reader.onload = function(){
      if (reader.readyState != 2 || reader.error){
        return;
      } else {
        convertToLayer(reader.result);
      }
    }
    reader.readAsArrayBuffer(file);
  };
  function convertToLayer(buffer){
    shp(buffer).then(function(geojson){ //More info: https://github.com/calvinmetcalf/shapefile-js
      var layer = L.shapefile(geojson).addTo(map);//More info: https://github.com/calvinmetcalf/leaflet.shapefile
      map.fitBounds(layer.getBounds());
      document.querySelector("#search-form > form > div.form-group.select.required.search_geom_input_option").hidden = true;
      document.querySelector("#form-4th-row").hidden = true;
      var layersKeys = Object.keys(layer._layers);
      var layerType = layer._layers[layersKeys[0]].feature.geometry.type.toUpperCase();
      console.log(layerType);
      if (layerType == "POLYGON" || layerType == "MULTIPOLYGON") {
        var wktText = "MULTIPOLYGON (";
        layersKeys.forEach( k => {
          wktText +=  "(";
          layer._layers[k].feature.geometry.coordinates.forEach( featPoly => {
            wktText += "(";
            featPoly.forEach( coordPair => {
              if (typeof coordPair[0] == 'number') {
                wktText += coordPair[0] + " " + coordPair[1] + ", ";
              } else {
                coordPair.forEach( deepCoordPair => {
                  wktText += deepCoordPair[0] + " " + deepCoordPair[1] + ", ";
                });
              }
            });
            wktText = wktText.slice(0, -2);
            wktText += "), ";
          });
          wktText = wktText.slice(0, -2);
          wktText += "), ";
        });
        wktText = wktText.slice(0, -2);
        wktText += ")";
      } else if (layerType == "LINESTRING" || layerType == "MULTILINESTRING") {
        var wktText = "MULTILINESTRING (";
        layersKeys.forEach( k => {
          //starts representation of a feature within the wktText
          wktText += "(";
          layer._layers[k].feature.geometry.coordinates.forEach( coordPair => {
            // checks if feature is simple
            if (typeof coordPair[0] == "number") {
              // arrange simple feature's coordinate pairs
              wktText += coordPair[0] + " " + coordPair[1] + ", ";
            } else {
              // iteration over multipart feature's coordinate pairs to make simplepart features
              coordPair.forEach( deepCoordPair => {
                // arrange feature part's coordinate pairs
                wktText += deepCoordPair[0] + " " + deepCoordPair[1] + ", ";
              });
              wktText = wktText.slice(0, -2);
              // closes representation of one feture part and starts another feature part
              wktText += "), (";
            };
          });
          // clears all part's ending and starting tags
          wktText = wktText.slice(0, -4);
          // finishes feature
          wktText += "), ";
        });
        wktText = wktText.slice(0, -2);
        // wktText = wktText.slice(0, -2);
        // closes wktText
        wktText += ")";
      } else {
        window.alert("Este arquivo não contém linhas ou polígonos.");
        return;
      }
      wktContainer.value = wktText;
      geometryReady = true;
      console.log(`Geometry form field is filled with ${wktContainer.value}`);
      industry.value !==  "" ? buttonDiv.hidden = false : buttonDiv.hidden = true;
    });
  }
};
export { mapDrawInit };
