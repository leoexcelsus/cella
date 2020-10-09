// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require('data-confirm-modal')
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

import "leaflet";
require("leaflet/dist/leaflet.css");
import "leaflet-draw";
require("leaflet-draw/dist/leaflet.draw.css");

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

import { mapDrawInit } from '../plugins/map_draw_init';

import { selectPolygon } from '../components/select_polygon';

import { drawPolygon } from '../components/draw_polygon';

import { showPolygon } from '../components/show_polygon';

import { leafletShpFile } from '../plugins/leaflet.shpfile';

import { shpJS } from '../plugins/shp';

// require( 'datatables.net-dt' )();

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
  mapDrawInit();
  selectPolygon();
  drawPolygon();
  showPolygon();
});

require ("../../../vendor/assets/dist/js/dsgov");
