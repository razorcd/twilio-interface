describe "Messanger" do
  it "should be defined" do
    expect(defined?(Messanger)).to be_truthy
  end

  it "should initialize" do
    instance= Messanger.new({account_id: "accountid", auth_id: "authid"})
    expect(instance).to be_a Messanger
    expect(instance.instance_variable_get("@account_id")).to eq "accountid"
    expect(instance.instance_variable_get("@auth_id")).to eq "authid"
  end

  context "send_message method" do
    let(:tp_double) { instance_double(TwilioProtocol) }
    let(:response_double) { double }

    before :each do
      expect(TwilioProtocol).to receive(:new).with(account_id: "accountid", auth_id: "authid").and_return(tp_double)
      @instance= Messanger.new({account_id: "accountid", auth_id: "authid"})
    end

    context "with valid params" do
      it "should be successful" do
        expect(tp_double).to receive(:post).with({from_number: "111", to_number: "222", body: "lorem"}).and_return(response_double)
        expect(response_double).to receive(:successful?).and_return(true)
        expect(response_double).not_to receive(:error_message)

        expect(@instance.send_message(from_number: "111", to_number: "222", body: "lorem")).to eq true
        expect(@instance.error_message).to eq(nil)
      end
    end

    context "with invalid params" do
      it "should be unsuccessful" do
        expect(tp_double).to receive(:post).with({from_number: "", to_number: "", body: "lorem"}).and_return(response_double)
        expect(response_double).to receive(:successful?).and_return(false)
        expect(response_double).to receive(:error_message).and_return("ERROR MESSAGE")

        expect(@instance.send_message(from_number: "", to_number: "", body: "lorem")).to eq false
        expect(@instance.error_message).to eq("ERROR MESSAGE")
      end
    end
  end

  context "list_messages method" do
    let(:tp_double) { instance_double(TwilioProtocol) }
    let(:response_double) { double }

    before :each do
      expect(TwilioProtocol).to receive(:new).with(account_id: "accountid", auth_id: "authid").and_return(tp_double)
      expect(tp_double).to receive(:get).and_return(response_double)
      @instance= Messanger.new({account_id: "accountid", auth_id: "authid"})
    end

    context "with correct params" do
      it "should return messages list" do
        expect(response_double).to receive(:successful?).and_return(true)
        expect(response_double).to receive(:messages).and_return([1,2,3])

        expect(@instance.list_messages).to eq([1,2,3])
        expect(@instance.error_message).to eq(nil)
      end
    end

    context "with incorrect params" do
      it "should NOT return messages list" do
        expect(response_double).to receive(:successful?).and_return(false)
        expect(response_double).to receive(:error_message).and_return("ERROR MESSAGE")

        @instance= Messanger.new({account_id: "accountid", auth_id: "authid"})

        expect(@instance.list_messages).to eq(nil)
        expect(@instance.error_message).to eq("ERROR MESSAGE")
      end
    end
  end
end
