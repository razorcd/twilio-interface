require 'json'
require_relative 'twilio_protocol'

class Messanger
  attr_reader :error_message

  def initialize account_id:, auth_id:
    @account_id= account_id
    @auth_id= auth_id
    @error_message= nil
  end

  def send_message from_number:, to_number:, body:
    response= twilio_protocol.post(from_number: from_number, to_number: to_number, body: body)
    if response.successful?
      @error_message= nil
      true
    else
      @error_message= response.error_message
      false
    end
  end

  def list_messages
    response= twilio_protocol.get
    if response.successful?
      @error_message= nil
      response.messages
    else
      @error_message= response.error_message
      nil
    end
  end

private

  def twilio_protocol
    @twilio_protocol||= TwilioProtocol.new(account_id: @account_id, auth_id: @auth_id)
  end
end
