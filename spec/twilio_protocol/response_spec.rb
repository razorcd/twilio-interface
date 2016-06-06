describe "Response" do
  let(:good_response_body) do
    '{
      "first_page_uri": "/2010-04-01/Accounts/AC7a9155ea350b00a7ff3c8d99d62ac0c5/Messages.json?PageSize=50&Page=0",
      "end": 49,
      "previous_page_uri": null,
      "messages": [
        {
          "sid": "SMb4213f8751e04b819b11cf2a80972287",
          "date_created": "Mon, 23 May 2016 10:21:45 +0000",
          "date_updated": "Mon, 23 May 2016 10:22:01 +0000",
          "date_sent": "Mon, 23 May 2016 10:21:45 +0000",
          "account_sid": "AC7a9155ea350b00a7ff3c8d99d62ac0c5",
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
          "uri": "/2010-04-01/Accounts/AC7a9155ea350b00a7ff3c8d99d62ac0c5/Messages/SMb4213f8751e04b819b11cf2a80972287.json",
          "subresource_uris": {
            "media": "/2010-04-01/Accounts/AC7a9155ea350b00a7ff3c8d99d62ac0c5/Messages/SMb4213f8751e04b819b11cf2a80972287/Media.json"
          }
        }
      ],
      "uri": "/2010-04-01/Accounts/AC7a9155ea350b00a7ff3c8d99d62ac0c5/Messages.json?PageSize=50&Page=0",
      "page_size": 50,
      "start": 0,
      "next_page_uri": "/2010-04-01/Accounts/AC7a9155ea350b00a7ff3c8d99d62ac0c5/Messages.json?PageSize=50&Page=1&PageToken=PASMd63342e222d0458d8ca9833104b27aaa",
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
      expect(Response.new(good_response_body, 200).successful?).to eq(true)
    end

    it "should return response messages as hashes" do
      expect(Response.new(good_response_body, 201).messages).to eq([
          {
            "sid" => "SMb4213f8751e04b819b11cf2a80972287",
            "date_created" => "Mon, 23 May 2016 10:21:45 +0000",
            "date_updated" => "Mon, 23 May 2016 10:22:01 +0000",
            "date_sent" => "Mon, 23 May 2016 10:21:45 +0000",
            "account_sid" => "AC7a9155ea350b00a7ff3c8d99d62ac0c5",
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
            "uri" => "/2010-04-01/Accounts/AC7a9155ea350b00a7ff3c8d99d62ac0c5/Messages/SMb4213f8751e04b819b11cf2a80972287.json",
            "subresource_uris" => {
              "media" => "/2010-04-01/Accounts/AC7a9155ea350b00a7ff3c8d99d62ac0c5/Messages/SMb4213f8751e04b819b11cf2a80972287/Media.json"
            }
          }
        ])
    end

    it "should NOT return error message" do
      expect(Response.new(good_response_body, 200).error_message).to eq(nil)
    end
  end

  context "UNsuccessful response" do
    it "should return unsuccessful" do
      expect(Response.new(bad_response_body, 404).successful?).to eq(false)
    end

    it "should NOT return response messages" do
      expect(Response.new(bad_response_body, 500).messages).to eq(nil)
    end

    it "should return error message" do
      expect(Response.new(bad_response_body, 400).error_message).to eq("The requested resource /2010-04-01/Accounts/a/Messages.json was not found")
    end
  end
end
