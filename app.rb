require 'sinatra'

set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :public_folder, 'public'
set :views, 'app/views'

require './app/routes'
