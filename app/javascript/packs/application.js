import 'bootstrap';
import '../stylesheets/application';
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")

import '../js/application.js'
import '../js/avatar_form.js'

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

// when cliclk hamburger menu
// $(document).on('turbolinks:load', function(){
//   $('.navbar-toggle').on('click', function() {
//     // if menu is opening, close menu
//     if($(ul).hasClass('show')) {
//       $('#navbar').removeClass('show');
//     } else {
//       $('#navbar').addClass('show');
//     }
//   });
// });
