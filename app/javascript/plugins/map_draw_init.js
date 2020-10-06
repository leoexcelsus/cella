const mapDrawInit = () => {
  console.log("Hello from map_draw_init function!!")
};


// Instantiate a Leaflet map if there is a div element whose id='map'
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


  // changes form according to user's decision
  const formGeoInputOption = document.getElementById('search_geom_input_option');
  formGeoInputOption.addEventListener('input', (event) => {
    console.log("Geometry input option is set");
    const drawingToolSelector = document.getElementById('form-3th-row');
    const upLoadButton = document.getElementById('form-4th-row');
    if (formGeoInputOption.value == "draw") {
      drawingToolSelector.hidden = false;
      upLoadButton.hidden = true;
    } else if (formGeoInputOption.value == "upload") {
      drawingToolSelector.hidden = true;
      upLoadButton.hidden = false;
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
        const wktContainer = document.getElementById('wkt-hidden-input');
        wktContainer.value = toWKT(layer);
        console.log(`Form input keeps only this geometry:\n${wktContainer.value}`);
      });
  });

  // Event defintion that saves drawing in Well Known Text format
  // into the hidden form fiel for the geometry
  map.on('draw:created', function (e) {
    var layer = e.layer;
    if (Object.keys(drawnItems._layers).length == 0) {
      drawnItems.addLayer(layer);
      formShapeOption.value = ""
      const wktContainer = document.getElementById('wkt-hidden-input');
      wktContainer.value = toWKT(layer);
      window.alert("Desenho georreferenciado adicionado ao formulário.");
      geometryReady = true;
      if (industry.value !==  "") {
        buttonDiv.hidden = false
      };
      console.log(`Form input keeps only this geometry:\n${wktContainer.value}`);
    } else {
      window.alert("Vocês está tentando acrescentar um novo polígono ou uma nova "
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

}

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
let industryReady = false
let geometryReady = false
const industry = document.querySelector("#search_industry");
const geometry = document.querySelector("#wkt-hidden-input");
const buttonDiv = document.getElementById('spatial-search-form-button');
industry.addEventListener("change", (event) => {
  console.log(`an industry event has taken place: Before: industryReady = ${industryReady}`);
  if (industry.value !==  "" && geometryReady == true) {
    buttonDiv.hidden = false
  } else if (industry.value !==  "" && geometryReady == false) {
    industryReady = true
  } else {
    industryReady = false;
    buttonDiv.hidden = true;
  }
  console.log(`an industry event has taken place: Afterwards: industryReady = ${industryReady}`);
});
map.on('draw:deleted', function (e) {
  console.log("A layer has been removed");
  console.log(`a geometry event has taken place: Before: geometryReady = ${geometryReady}`);
  geometryReady = false;
  buttonDiv.hidden = true;
  console.log(`a geometry event has taken place: Afterwards: geometryReady = ${geometryReady}`);
});

export { mapDrawInit };
