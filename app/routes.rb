require_relative "messanger"

get '/' do
  erb :index
end

post '/send_message' do
  # TODO: add strong params
  # params['account_id']= "XXXX"
  # params['auth_id']= "xxxx"
  # params['from_number']= "111"
  # params['to_number']= "111"
  # params['body']= "1234567"
  successful= Messanger.new(account_id: params['account_id'], auth_id: params['auth_id']).
      send_message(from_number: params['from_number'], to_number: params['to_number'], body: params['body'])


  headers "Content-Type" => "application/json"
  successful ? status(201) : status(406)
  # if successful
  #   erb(:index, locals: {success_flash: "SUCCESS FLASH"})
  # else
  #   erb(:index, locals: {error_flash: "ERROR FLASH"})
  # end
end

get '/list_messages' do
  # TODO: add strong params
  headers "Content-Type" => "application/json"
  # params['account_id']= "XXXX"
  # params['auth_id']= "xxxx"
  Messanger.new(account_id: params['account_id'], auth_id: params['auth_id']).list_messages
end
