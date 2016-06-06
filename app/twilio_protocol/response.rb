require 'json'

class Response
  def initialize body, status
    @body= body
    @status= status
  end

  def successful?
    @status.to_s[0]=="2"
  end

  def messages
    json_body["messages"]
  end

  def error_message
    json_body["message"]
  end

private

  def json_body
    JSON.parse(@body)
  end

end
