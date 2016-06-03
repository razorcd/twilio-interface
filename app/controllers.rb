require 'json'
require_relative "messanger"

get '/' do
  erb :index
end

post '/send_message' do
  strong_params= strong_send_message_params params
  successful= Messanger.new(account_id: strong_params[:account_id], auth_id: strong_params[:auth_id]).
      send_message(from_number: strong_params[:from_number], to_number: strong_params[:to_number], body: strong_params[:body])


  headers "Content-Type" => "application/json"
  successful ? status(201) : status(406)

  if successful
    {flash_message: "SUCCESS FLASH"}.to_json
  else
    {flash_message: "ERROR FLASH"}.to_json
  end
end

get '/list_messages' do
  headers "Content-Type" => "application/json"
  strong_params= strong_list_messages_params params
  Messanger.new(account_id: strong_params[:account_id], auth_id: strong_params[:auth_id]).
    list_messages
end
