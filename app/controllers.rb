require 'json'
require_relative "messanger"

get '/' do
  erb :index
end

post '/send_message' do
  strong_params= strong_send_message_params params
  headers "Content-Type" => "application/json"
  if message_sent?(params: strong_params)
    status(201)
    {flash_message: "SUCCESS FLASH"}.to_json
  else
    status(406)
    {flash_message: "ERROR FLASH"}.to_json
  end
end

get '/list_messages' do
  headers "Content-Type" => "application/json"
  strong_params= strong_list_messages_params params
  messages_list(params: strong_params).to_json
end

def message_sent? params:
  Messanger.new(account_id: params[:account_id], auth_id: params[:auth_id]).
      send_message(from_number: params[:from_number], to_number: params[:to_number], body: params[:body])
end

def messages_list params:
  Messanger.new(account_id: params[:account_id], auth_id: params[:auth_id]).list_messages
end
