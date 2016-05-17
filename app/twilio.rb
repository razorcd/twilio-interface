class Twilio
  def initialize account_id:, auth_id:
    @account_id= account_id
    @auth_id= auth_id
  end

  def send_message from_number:, to_number:, body:
    `
      curl -X POST 'https://api.twilio.com/2010-04-01/Accounts/#{@account_id}/Messages.json' \
      --data-urlencode 'From=#{from_number}'  \
      --data-urlencode 'To=#{to_number}'  \
      --data-urlencode 'Body=#{body}'  \
      -u #{@account_id}:#{auth_id}
    `
  end

  def list_messages
    `curl -G https://api.twilio.com/2010-04-01/Accounts/#{@account_id}/Messages.json -u '#{@account_id}:#{@auth_id}'`
  end
end
