describe "Messanger" do
  it "should be defined" do
    expect(defined? Messanger).to be_truthy
  end

  it "should initialize" do
    instance= Messanger.new({account_id: "accountid", auth_id: "authid"})
    expect(instance).to be_a Messanger
    expect(instance.instance_variable_get("@account_id")).to eq "accountid"
    expect(instance.instance_variable_get("@auth_id")).to eq "authid"
  end

  context "send_message method" do
    it "should be defined" do
      expect(Messanger.instance_method(:send_message)).to be_truthy
    end

    context "when posting message with TwilioProtocol" do
      let(:tp_double) { instance_double(TwilioProtocol) }
      let(:post_double) { double }

      before :each do
        expect(TwilioProtocol).to receive(:new).with(account_id: "accountid", auth_id: "authid").and_return(tp_double)
        @instance= Messanger.new({account_id: "accountid", auth_id: "authid"})
      end

      it "should be successful for correct params" do
        expect(tp_double).to receive(:post).with({from_number: "111", to_number: "222", body: "lorem"}).and_return(post_double)
        expect(post_double).to receive_message_chain(:code, "[]").and_return("2")

        expect(@instance.send_message(from_number: "111", to_number: "222", body: "lorem")).to eq true
      end

      it "should be unsuccessful for incorrect params" do
        expect(tp_double).to receive(:post).with({from_number: "", to_number: "", body: "lorem"}).and_return(post_double)
        expect(post_double).to receive_message_chain(:code, "[]").and_return("4")

        expect(@instance.send_message(from_number: "", to_number: "", body: "lorem")).to eq false
      end
    end
  end

  context "list_messages method" do
    it "should be defined" do
      expect(Messanger.instance_method(:list_messages)).to be_truthy
    end

    it "should return return TwilioProtocol response" do
      tp_double= instance_double(TwilioProtocol)
      get_double= double

      expect(TwilioProtocol).to receive(:new).with(account_id: "accountid", auth_id: "authid").and_return(tp_double)
      expect(tp_double).to receive(:get).and_return(get_double)
      expect(get_double).to receive(:body).and_return("{\"messages\":{\"msg1\":\"message1\",\"msg2\":\"message2\"}}")

      instance= Messanger.new({account_id: "accountid", auth_id: "authid"})

      expect(instance.list_messages).to eq({"msg1" => "message1", "msg2" => "message2"})
    end
  end
end
