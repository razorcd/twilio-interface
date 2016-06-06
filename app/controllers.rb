require 'json'
require_relative "messanger"

get '/' do
  erb :index, locals: {account: {}}
end

get '/list_messages' do
  strong_params= strong_list_messages_params params
  messanger= Messanger.new(strong_params)
  message_list= messanger.list_messages
  if message_list
    erb :index, locals: {account: credentials_from(strong_params), message_list: message_list}
  else
    erb :index, locals: {account: credentials_from(strong_params), flash: {error_flash: messanger.error_message}}
  end
end

post '/send_message' do
  strong_params= strong_send_message_params params

  if message_sent?(params: strong_params)
    strong_params[:body]= ""
    erb :index, locals: {account: strong_params, flash: {success_flash: "SUCCESS FLASH"}}
  else
    erb :index, locals: {account: strong_params, flash: {error_flash: "ERROR FLASH"}}
  end
end

def message_sent? params:
  Messanger.new(credentials_from(params)).
      send_message(from_number: params[:from_number], to_number: params[:to_number], body: params[:body])
end

def credentials_from params
  {account_id: params[:account_id], auth_id: params[:auth_id]}
end
