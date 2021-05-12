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
import $ from 'jquery'
import 'select2';
import 'semantic-ui-css/semantic.min.css'
import "react-loader-spinner/dist/loader/css/react-spinner-loader.css";
require('datatables.net')
require('datatables.net-dt')
require("chartkick/chart.js")
require("popper.js")
require('select2')
require('moment')
require('select2/dist/css/select2.css')
require('semantic-ui-react')
require('semantic-ui-css')
require('react-transition-group')
require('bootstrap')
require('@pdftron/pdfjs-express')
require('framer-motion')
require('react-loader-spinner')

Rails.start()
ActiveStorage.start()

$(document).ready(()=>{
    $('.select2').select2({
        tags: true
    });
})