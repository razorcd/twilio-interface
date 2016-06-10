require 'json'

class Response
  PERMITED_PARAMS= [
    :date_created, :date_updated, :date_sent, :to, :from,
    :body, :status, :num_segments, :num_media, :direction,
    :api_version, :price, :price_unit, :error_code, :error_message,
  ]
  UNPERMITED_PARAMS= [:sid, :account_sid, :messaging_service_sid, :uri, :subresource_uris]

  def initialize json_body, status
    @json_body= json_body
    @status= status
  end

  def successful?
    @status.to_s[0]=="2"
  end

  def messages
    body["messages"] && permited_keys_for(body["messages"])
  end

  def error_message
    body["message"]
  end

private

  def body
    JSON.parse(@json_body)
  end

  def permited_keys_for all_messages
    all_messages= all_messages.dup
    all_messages.each do |message|
      message.keys.each do |k|
        message.delete(k) unless PERMITED_PARAMS.include?(k.to_sym)
      end
    end
  end

end
