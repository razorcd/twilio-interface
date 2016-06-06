require 'net/http'
# require 'net/https'
require "uri"

files= Dir.entries('./app/twilio_protocol').select {|f| f[-3,3]==".rb"}
files.each {|f| require_relative "./twilio_protocol/#{f}"}

class TwilioProtocol
  def initialize account_id:, auth_id:
    @account_id= account_id
    @auth_id= auth_id
  end

  def get
    request= Net::HTTP::Get.new(uri.request_uri)
    request.basic_auth(@account_id, @auth_id)

    response= server.request(request)
    Response.new response.body, response.code
  end

    # `
    #   curl -X POST 'https://api.twilio.com/2010-04-01/Accounts/#{@account_id}/Messages.json' \
    #   --data-urlencode 'From=+17083406400'  \
    #   --data-urlencode 'To="+40742558551"'  \
    #   --data-urlencode 'Body="1234"'  \
    #   -u #{@account_id}:#{@auth_id}
    # `
  def post from_number:, to_number:, body:
    request= Net::HTTP::Post.new(uri.request_uri)
    request.basic_auth(@account_id, @auth_id)
    request.set_form_data({
      "From" => from_number,
      "To" => to_number,
      "Body" => body,
    })

    response = server.request(request)
    Response.new response.body, response.code
  end

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
