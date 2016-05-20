require_relative 'twilio_protocol'

class Messanger
  def initialize account_id:, auth_id:
    raise "Invalid Twilio params" if account_id.to_s.empty? || auth_id.to_s.empty?
    @account_id= account_id
    @auth_id= auth_id
  end

  def send_message from_number:, to_number:, body:
    response= twilio_tp.post(from_number: from_number, to_number: to_number, body: body)
    response.code[0]=="2"
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
