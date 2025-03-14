# frozen_string_literal: true

source 'https://rubygems.org'

group :preload do
	gem 'utopia', '~> 2.29'
	# gem 'utopia-gallery'
	# gem 'utopia-analytics'
	
	gem 'variant'
end

gem 'bake'
gem 'bundler'
gem 'rack-test'
gem 'net-smtp'

group :production do
	gem 'falcon'
end
