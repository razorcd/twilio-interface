describe "route" do
  context "GET '/'" do
    it "should allow access" do
      get '/'
      expect(last_response).to be_ok
    end

    it "should render :index erb view" do
      expect_any_instance_of(app).to receive(:erb).with(:index)
      get '/'
    end
  end

  context "POST '/send_message'" do
    it "should allow access" do
      post '/send_message'
      expect(last_response).to be_ok
    end
  end

  context "GET '/list_messages'" do
    before :each do
      class_double(Twilio)
      twilioDouble = instance_double(Twilio)
      expect(Twilio).to receive(:new).with({account_id: "accountid", auth_id: "authid"}).and_return(twilioDouble)
      expect(twilioDouble).to receive(:list_messages).and_return("messages_json")
    end

    it "should allow access" do
      get '/list_messages?account_id=accountid&auth_id=authid'
      expect(last_response).to be_ok
    end

    it "should return message list" do
      get '/list_messages?account_id=accountid&auth_id=authid'
      expect(last_response.body).to eq "messages_json"
    end

    it "should return json content type" do
      get '/list_messages?account_id=accountid&auth_id=authid'
      expect(last_response.content_type).to match("json")
    end
  end

end
