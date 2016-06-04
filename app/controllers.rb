require 'json'
require_relative "messanger"

get '/' do
  erb :index, locals: {account: {}}
end

post '/send_message' do
  strong_params= strong_send_message_params params

  if message_sent?(params: strong_params)
    erb :index, locals: {account: credentials_from(params: strong_params), success_flash: "SUCCESS FLASH"}
  else
    erb :index, locals: {account: credentials_from(params: strong_params), error_flash: "ERROR FLASH"}
  end
end

get '/list_messages' do
  headers "Content-Type" => "application/json"
  strong_params= strong_list_messages_params params
  messages_list= messages_list(params: strong_params)
  erb :index, locals: {account: credentials_from(params: strong_params), message_list: messages_list}
end

def message_sent? params:
  Messanger.new(account_id: params[:account_id], auth_id: params[:auth_id]).
      send_message(from_number: params[:from_number], to_number: params[:to_number], body: params[:body])
end

def messages_list params:
  Messanger.new(account_id: params[:account_id], auth_id: params[:auth_id]).list_messages
end

def credentials_from params:
  {account_id: params[:account_id], auth_id: params[:auth_id]}
end
