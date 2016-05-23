require 'sinatra'
require './app'

compass_config= File.join(Sinatra::Application.root, 'config', 'compass.rb')
`compass compile -c #{compass_config}`

run Sinatra::Application
