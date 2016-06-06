describe "TwilioProtocol" do
  # let(:response_double) {instance_double Response}

  it "should be defined" do
    expect(defined?(TwilioProtocol).!.!).to be_truthy
  end

  it "should initialize" do
    instance= TwilioProtocol.new({account_id: "accountid", auth_id: "authid"})
    expect(instance).to be_a TwilioProtocol
    expect(instance.instance_variable_get("@account_id")).to eq "accountid"
    expect(instance.instance_variable_get("@auth_id")).to eq "authid"
  end

  context "get method" do
    it "should be defined" do
      expect(TwilioProtocol.instance_method(:get)).to be_truthy
    end

    it "should send get list of messages from twilio" do
      server= double(Net::HTTP)
      http_response_double= double
      http_response_body_double= double
      response_double= instance_double(Response)

      expect(Net::HTTP).to receive(:new).and_return(server)
      expect(server).to receive(:request).and_return(http_response_double)
      expect(http_response_double).to receive(:body).and_return(http_response_body_double)
      expect(http_response_double).to receive(:code).and_return(200)
      allow(server).to receive(:use_ssl=)
      expect(Response).to receive(:new).with(http_response_body_double, 200).and_return(response_double)

      instance= TwilioProtocol.new({account_id: "accountid", auth_id: "authid"})

      expect(instance.get).to eq(response_double)
    end
  end

  context "post method" do
    it "should be defined" do
      expect(TwilioProtocol.instance_method(:post)).to be_truthy
    end

    it "should post message to twilio" do
      server= double(Net::HTTP)
      http_response_double= double
      http_response_body_double= double
      response_double= instance_double(Response)

      expect(Net::HTTP).to receive(:new).and_return(server)
      expect(server).to receive(:request).and_return(http_response_double)
      expect(http_response_double).to receive(:body).and_return(http_response_body_double)
      expect(http_response_double).to receive(:code).and_return(200)
      allow(server).to receive(:use_ssl=)
      expect(Response).to receive(:new).with(http_response_body_double, 200).and_return(response_double)

      instance= TwilioProtocol.new({account_id: "accountid", auth_id: "authid"})

      expect(instance.post from_number: "111", to_number: "222", body: "lorem").to eq(response_double)
    end
  end
end
