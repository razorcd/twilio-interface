require 'json'

class Response
  attr_reader :response_body

  def initialize response_body
    @response_body= response_body
  end

  def successful?
    status= json_response_body["status"]
    return false if status && status.to_s[0] != 2
    true
  end

  def messages
    json_response_body["messages"]
  end

  def error_message
    json_response_body["message"]
  end

private

  def json_response_body
    JSON.parse(response_body)
  end

end
