source 'https://rubygems.org'
 
gem 'rails', '3.2.3'
# gem "net-ssh-gateway"
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# for database
gem "mysql2"
gem 'hashdiff'

gem 'dbd-mysql'

gem 'pg'


# authentication
gem "sorcery",  :git =>  "git://github.com/NoamB/sorcery.git"

#form generation
gem 'simple_form'
gem 'nested_form'

# file attachment
gem "carrierwave", "~> 0.5.8"
gem "fog", "~> 1.1.2"
#fancybox
gem 'fancybox2-rails', '~> 0.2.4'
gem "jquery-treeview-rails"

#for ruby zip files
gem 'rubyzip'
gem 'rmagick'
 
# searching
gem "ransack", "~> 0.6.0"

# friendly_id
gem "friendly_id", "~> 4.0.3"

# pagination
gem "kaminari", "~> 0.13.0"

gem 'sqlite3'

gem 'pdfkit'
gem 'wkhtmltopdf-binary'
gem 'prawn'

# captcha
gem "recaptcha", :require => "recaptcha/rails"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.5'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'bootstrap-sass', '~> 2.0.2'
  gem 'bootstrap-colorpicker-rails', :require => 'bootstrap-colorpicker-rails',
                          :git => 'git://github.com/alessani/bootstrap-colorpicker-rails.git'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

#gem 'jquery-rails'
gem 'jquery-rails', "~> 2.3.0"

# testing
group :test, :development do
  gem "capybara", "~> 1.1.2"
  gem "rspec-rails", "~> 2.9.0"
  gem 'launchy'
  gem "factory_girl_rails", "~> 3.1"
  gem 'spork-rails'
  gem 'foreman'
  gem 'database_cleaner'
end

group :development do
  gem 'pry-rails'
  gem 'pry-doc'
  
  # To use debugger
  # gem 'ruby-debug19', :require => 'ruby-debug'
end

group :production do
  gem 'thin'
  gem 'newrelic_rpm'
  gem 'airbrake'
end

gem 'rails_autolink'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
