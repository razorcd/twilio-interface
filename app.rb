require 'sinatra'
require 'sass'
require 'compass'

configure do
  set :root, "app/"
  set :public, 'public/'

  Compass.configuration do |config|
    config.project_path = File.dirname(__FILE__)
    config.sass_dir = 'views'
  end

  set :sass, Compass.sass_engine_options
  set :scss, Compass.sass_engine_options
end

# get 'public/stylesheets/:name.css' do
#   content_type 'text/css', :charset => 'utf-8'
#   sass(:"../public/stylesheets/#{params[:name]}", Compass.sass_engine_options )
# end

require './app/routes'





