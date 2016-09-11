const $ = require("jquery");
const Turbolinks = require("turbolinks");
const Vue = require("vue");

$(document).on("turbolinks:load", function() {
  Vue.config.debug = true;

  new Vue({
    el: "body"
  });
});

Turbolinks.start();
