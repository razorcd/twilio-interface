require_relative "messanger"

get '/' do
  erb :index
end

post '/send_message' do
  parsed_params= parsed_send_message_params params
  successful= Messanger.new(account_id: parsed_params[:account_id], auth_id: parsed_params[:auth_id]).
      send_message(from_number: parsed_params[:from_number], to_number: parsed_params[:to_number], body: parsed_params[:body])


  headers "Content-Type" => "application/json"
  successful ? status(201) : status(406)
  # if successful
  #   erb(:index, locals: {success_flash: "SUCCESS FLASH"})
  # else
  #   erb(:index, locals: {error_flash: "ERROR FLASH"})
  # end
end

get '/list_messages' do
  headers "Content-Type" => "application/json"
  parsed_params= parsed_list_messages_params params
  Messanger.new(account_id: parsed_params[:account_id], auth_id: parsed_params[:auth_id]).list_messages
end

def parsed_send_message_params params
  {
    account_id: params["account_id_clone"],
    auth_id: params["auth_id_clone"],
    from_number: params["from_number"],
    to_number: params["to_number"],
    body: params["body"],
  }
end

def parsed_list_messages_params params
  {
    account_id: params["account_id_clone"],
    auth_id: params["auth_id_clone"],
  }
end
