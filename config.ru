require 'rake'
require 'sinatra'
require './app'

Rake.application.init
Rake.application.load_rakefile
Rake.application['SASS:compile'].invoke
Rake.application['JS:copy'].invoke

run Sinatra::Application
