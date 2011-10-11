source 'http://rubygems.org'

gem 'rails', '3.1.1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'haml'
gem 'haml-rails'

gem 'mongoid'
gem 'bson_ext'

gem 'oauth'

gem 'thin'

group :test do
	gem 'rspec'
	gem 'rspec-rails'

	gem 'autotest'
	
	gem 'machinist', '>= 2.0.0.beta2'
	gem 'machinist_mongo', :git => 'https://github.com/nmerouze/machinist_mongo.git', 
		:branch => 'machinist2', :require => 'machinist/mongoid'
	
	gem 'capybara'
end

group :development, :test do
	gem 'ruby-debug19', :require => 'ruby-debug'
end 

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

