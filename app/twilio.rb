require 'pry'
require_relative 'twilio_protocol'

class Twilio
  def initialize account_id:, auth_id:
    raise "Invalid Twilio params" if account_id.to_s.empty? || auth_id.to_s.empty?
    @account_id= account_id
    @auth_id= auth_id
  end

  def send_message from_number:, to_number:, body:
    `
      curl -X POST 'https://api.twilio.com/2010-04-01/Accounts/#{@account_id}/Messages.json' \
      --data-urlencode 'From=#{from_number}'  \
      --data-urlencode 'To=#{to_number}'  \
      --data-urlencode 'Body=#{body}'  \
      -u #{@account_id}:#{@auth_id}
    `
    # params= { @account_id => @auth_id }
    # uri.query= URI.encode_www_form(params)
  end

  def list_messages
    response= twilio_tp.get
    response.body
  end

private

  def twilio_tp
    @twilio_tp||= TwilioProtocol.new(account_id: @account_id, auth_id: @auth_id)
  end

end
