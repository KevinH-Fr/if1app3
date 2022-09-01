// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "controllers"
import "@hotwired/turbo-rails"

require("@rails/activestorage").start()

//= require jquery
//= require jquery_ujs




import * as echarts from 'echarts';
import 'echarts/theme/dark';

window.echarts = echarts;

