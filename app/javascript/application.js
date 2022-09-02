// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "controllers"

//import "@hotwired/turbo-rails"
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false

require("@rails/activestorage").start()



//= require jquery
//= require jquery_ujs
//= require Chart.min


