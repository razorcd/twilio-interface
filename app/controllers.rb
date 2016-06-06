require 'json'
require_relative "messanger"

get '/' do
  erb :index, locals: {account: {}}
end

post '/list_messages' do
  strong_params= strong_params_for params
  messanger= Messanger.new(credentials_from(strong_params))
  message_list= messanger.list_messages
  if message_list
    erb :index, locals: {account: strong_params, message_list: message_list}
  else
    erb :index, locals: {account: strong_params, flash: {error_flash: messanger.error_message}}
  end
end

post '/send_message' do
  strong_params= strong_params_for params

  if message_sent?(params: strong_params)
    strong_params[:body]= ""
    erb :index, locals: {account: strong_params, flash: {success_flash: "Message was sent successfully."}}
  else
    erb :index, locals: {account: strong_params, flash: {error_flash: "Message sending failed."}}
  end
end

def message_sent? params:
  Messanger.new(credentials_from(params)).
      send_message(from_number: params[:from_number], to_number: params[:to_number], body: params[:body])
end

def credentials_from params
  {account_id: params[:account_id], auth_id: params[:auth_id]}
end

def strong_params_for params
  {
    account_id: params["account_id"],
    auth_id: params["auth_id"],
    from_number: params["from_number"],
    to_number: params["to_number"],
    body: params["body"],
  }
end
