namespace :SASS do
  desc 'Compiles all asset SASS files to public css'
  task :compile do
    compass_config= File.join(File.dirname(__FILE__), 'config', 'compass.rb')
    `compass compile -c #{compass_config}`
  end
end

namespace :JS do
  desc 'Moves all asset JS files to public js'
  task :copy do
    source_js= File.join(File.dirname(__FILE__), 'app', 'assets', 'javascripts', '*')
    dest_js= File.join(File.dirname(__FILE__), 'public', 'javascripts')
    `cp -r #{source_js} #{dest_js}`
  end
end

desc "starts web server"
task :start do
  port= ENV['$PORT'] || 9292
  exec "thin start -r config.ru -p #{port}"
end
