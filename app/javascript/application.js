// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "controllers"
import "@hotwired/turbo-rails"

require("@rails/activestorage").start()

//= require jquery
//= require jquery_ujs

window.dispatchMapsEvent = function (...args) {
    const event = document.createEvent("Events")
    event.initEvent("google-maps-callback", true, true)
    event.args = args
    window.dispatchEvent(event)
  }