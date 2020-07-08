// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// custom JS from the Plan-ET crew! 🤘
require("custom/carousel")

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

// External import
import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css';
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';
import { initAutocomplete } from '../plugins/init_autocomplete';

import { initMapbox } from '../plugins/init_mapbox';

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

document.addEventListener('turbolinks:load', () => {
  initMapbox();
  initAutocomplete();
  // Call your functions here, e.g:
  // initSelect2();
});
