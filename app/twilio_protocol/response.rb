require 'json'

class TwilioProtocol::Response
  def initialize response
    @response= response
  end

  def successful?
    status= json_response["status"]
    return false if status && status.to_s[0] != 2
    true
  end

  def messages
    json_response["messages"]
  end

  def error_message
    json_response["message"]
  end

private

  def json_response
    JSON.parse(@response)
  end

end
