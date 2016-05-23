namespace :SASS do
  desc 'Compiles all SASS files to CSS'
  task :compile do
    compass_config= File.join(File.dirname(__FILE__), 'config', 'compass.rb')
    `compass compile -c #{compass_config}`
  end
end
