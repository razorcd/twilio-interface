describe "Response" do
  let(:good_response_body) do
    '{
      "first_page_uri": "/2010-04-01/Accounts/AccountSID/Messages.json?PageSize=50&Page=0",
      "end": 49,
      "previous_page_uri": null,
      "messages": [
        {
          "sid": "sid",
          "date_created": "Mon, 23 May 2016 10:21:45 +0000",
          "date_updated": "Mon, 23 May 2016 10:22:01 +0000",
          "date_sent": "Mon, 23 May 2016 10:21:45 +0000",
          "account_sid": "AccountSID",
          "to": "+4915205244797",
          "from": "+17083406400",
          "messaging_service_sid": null,
          "body": "test1234",
          "status": "delivered",
          "num_segments": "1",
          "num_media": "0",
          "direction": "outbound-api",
          "api_version": "2010-04-01",
          "price": "-0.07000",
          "price_unit": "USD",
          "error_code": null,
          "error_message": null,
          "uri": "/2010-04-01/Accounts/AccountSID/Messages/sid.json",
          "subresource_uris": {
            "media": "/2010-04-01/Accounts/AccountSID/Messages/sid/Media.json"
          }
        }
      ],
      "uri": "/2010-04-01/Accounts/AccountSID/Messages.json?PageSize=50&Page=0",
      "page_size": 50,
      "start": 0,
      "next_page_uri": "/2010-04-01/Accounts/AccountSID/Messages.json?PageSize=50&Page=1&PageToken=Pages",
      "page": 0
    }'
  end

  let(:bad_response_body) do
    '{"code": 20404, "message": "The requested resource /2010-04-01/Accounts/a/Messages.json was not found", "more_info": "https://www.twilio.com/docs/errors/20404", "status": 404}'
  end


  it "should be defined" do
    expect(defined?(Response).!.!).to be_truthy
  end

  context "successful response" do
    it "should return successful" do
      expect(Response.new(good_response_body).successful?).to eq(true)
    end

    it "should return response messages as hashes" do
      expect(Response.new(good_response_body).messages).to eq([
          {
            "sid" => "sid",
            "date_created" => "Mon, 23 May 2016 10:21:45 +0000",
            "date_updated" => "Mon, 23 May 2016 10:22:01 +0000",
            "date_sent" => "Mon, 23 May 2016 10:21:45 +0000",
            "account_sid" => "AccountSID",
            "to" => "+4915205244797",
            "from" => "+17083406400",
            "messaging_service_sid" => nil,
            "body" => "test1234",
            "status" => "delivered",
            "num_segments" => "1",
            "num_media" => "0",
            "direction" => "outbound-api",
            "api_version" => "2010-04-01",
            "price" => "-0.07000",
            "price_unit" => "USD",
            "error_code" => nil,
            "error_message" => nil,
            "uri" => "/2010-04-01/Accounts/AccountSID/Messages/sid.json",
            "subresource_uris" => {
              "media" => "/2010-04-01/Accounts/AccountSID/Messages/sid/Media.json"
            }
          }
        ])
    end

    it "should NOT return error message" do
      expect(Response.new(good_response_body).error_message).to eq(nil)
    end
  end

  context "UNsuccessful response" do
    it "should return unsuccessful" do
      expect(Response.new(bad_response_body).successful?).to eq(false)
    end

    it "should NOT return response messages" do
      expect(Response.new(bad_response_body).messages).to eq(nil)
    end

    it "should return error message" do
      expect(Response.new(bad_response_body).error_message).to eq("The requested resource /2010-04-01/Accounts/a/Messages.json was not found")
    end
  end
end
