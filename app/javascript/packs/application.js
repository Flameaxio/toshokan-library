// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.


//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap-sprockets
//= require jquery.overlayScrollbars
//= require humanize-string

import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "@fortawesome/fontawesome-free/css/all"
require('bootstrap')


Rails.start()
ActiveStorage.start()

$(function() {
    //The passed argument has to be at least a empty object or a object with your desired options
});
