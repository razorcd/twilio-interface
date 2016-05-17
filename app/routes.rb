require_relative "twilio"

get '/' do
  erb :index
end

post '/send_message' do
  # erb :index, locals: {success_flash: "Message Sent Successfully"}
  erb(:index, locals: {success_flash: "SUCCESS FLASH", error_flash: "ERROR FLASH"})
end

get '/list_messages' do
  headers "Content-Type" => "application/json"
  Twilio.new(account_id: params['account_id'], auth_id: params['auth_id']).list_messages
end
