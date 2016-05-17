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

  it "should send message" do
    expect(Twilio.instance_method(:send_message)).to be_truthy
  end

  it "should list messages" do
    expect(Twilio.instance_method(:list_messages)).to be_truthy
  end
end
