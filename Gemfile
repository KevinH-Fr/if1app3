source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"
gem "rails", "~> 7.0.3"
gem "sprockets-rails"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data" #, platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem 'ransack'
gem 'kaminari'
gem "sassc-rails"
gem 'cloudinary'
gem "hotwire-rails"


#gem 'wicked_pdf'

#gem "wkhtmltopdf-binary", group: :development
#gem "wkhtmltopdf-heroku", group: :production

#gem 'imgkit'

gem 'grover'

#gem "mini_magick"
#"gem 'rmagick'

gem 'active_analytics'

gem 'open-weather-ruby-client'

#gem "chartkick"

#gem 'chart-js-rails'

#gem "rails_charts"

# inside Gemfile
gem 'letter_opener', group: :development


gem 'chart-js-rails'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'dotenv-rails'
end

group :development do
  gem "web-console"
  gem "sqlite3", "~> 1.4"


end

group :production do
  gem 'pg', '~> 1.4', '>= 1.4.1'
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

#group :development, :test do
#  gem 'foreman'
#end

gem "devise", "~> 4.8"
