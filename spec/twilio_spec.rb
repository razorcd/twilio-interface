require "pry"
describe "Twilio" do
  it "should be defined" do
    expect(defined? Twilio).to be_truthy
  end

  it "should initialize" do
    instance= Twilio.new({account_id: "accountid", auth_id: "authid"})
    expect(instance).to be_a Twilio
    expect(instance.instance_variable_get("@account_id")).to eq "accountid"
    expect(instance.instance_variable_get("@auth_id")).to eq "authid"
  end

  context "send_message method" do
    it "should be defined" do
      expect(Twilio.instance_method(:send_message)).to be_truthy
    end

    # it "should create new message" do


    # end
  end

  context "list_messages method" do
    it "should be defined" do
      expect(Twilio.instance_method(:list_messages)).to be_truthy
    end

    it "should return message body" do
      tp_double= instance_double(TwilioProtocol)
      get_double= double

      expect(TwilioProtocol).to receive(:new).with(account_id: "accountid", auth_id: "authid").and_return(tp_double)
      expect(tp_double).to receive(:get).and_return(get_double)
      expect(get_double).to receive(:body).and_return({msg1: "message1", msg2: "message2"})

      instance= Twilio.new({account_id: "accountid", auth_id: "authid"})

      expect(instance.list_messages).to eq({msg1: "message1", msg2: "message2"})
    end
  end
end
