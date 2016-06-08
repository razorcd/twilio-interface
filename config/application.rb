require_relative "version"

set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :public_folder, 'public'
set :views, 'app/views'
set :logger, Logger.new(STDOUT)
set :version, Version::VERSION
