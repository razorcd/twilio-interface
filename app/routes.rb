get '/' do
  erb :index
end

post '/send_message' do
  # erb :index, locals: {success_flash: "Message Sent Successfully"}
  erb(:index, locals: {success_flash: "SUCCESS FLASH", error_flash: "ERROR FLASH"})
end
