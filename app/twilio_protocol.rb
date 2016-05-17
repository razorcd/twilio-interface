require 'net/http'
# require 'net/https'
require "uri"

class TwilioProtocol
  def initialize account_id:, auth_id:
    raise "Invalid TwilioProtocol params" if account_id.to_s.empty? || auth_id.to_s.empty?
    @account_id= account_id
    @auth_id= auth_id
  end

  def get
    request= Net::HTTP::Get.new(uri.request_uri)
    request.basic_auth(@account_id, @auth_id)

    response= server.request(request)
  end

  # def post body:
  #   # headers.map {|h| req[h.key]= h.value}
  # end

private

  def uri
    @uri||= URI.parse("https://api.twilio.com/2010-04-01/Accounts/#{@account_id}/Messages.json")
  end

  def server
    @server||= begin
      http= Net::HTTP.new(uri.hostname, uri.port)
      http.use_ssl= true if uri.port == 443
      http
    end
  end
end
