describe "controllers" do
  context "GET '/'" do
    it "should allow access" do
      get '/'
      expect(last_response).to be_ok
    end

    it "should render :index erb view" do
      expect_any_instance_of(app).to receive(:erb).with(:index, locals: {account: {}})
      get '/'
    end
  end

  context "GET '/list_messages'" do
    before :each do
      class_double(Messanger)
      messanger_double = instance_double(Messanger)
      expect(Messanger).to receive(:new).with({account_id: "accountid", auth_id: "authid"}).and_return(messanger_double)
      expect(messanger_double).to receive(:list_messages).and_return({message_list: "data"})
    end

    it "should allow access" do
      expect_any_instance_of(app).to receive(:erb).with(:index, locals: {account: {account_id: "accountid", auth_id: "authid"}, message_list: {message_list: "data"}})

      get '/list_messages?account_id=accountid&auth_id=authid'
      expect(last_response).to be_ok
    end

    it "should return message list" do
      expect_any_instance_of(app).to receive(:erb).with(:index, locals: {account: {account_id: "accountid", auth_id: "authid"}, message_list: {message_list: "data"}})

      get '/list_messages?account_id=accountid&auth_id=authid'
    end
  end

  context "POST '/send_message'" do
    let(:messanger_double) { instance_double(Messanger) }
    before :each do
      class_double(Messanger)
      expect(Messanger).to receive(:new).with({account_id: "accountid", auth_id: "authid"}).and_return(messanger_double)
    end

    it "should return success when post message is successful" do
      success_erb_params= [:index, locals: {account: {account_id: "accountid", auth_id: "authid"}, success_flash: "SUCCESS FLASH"}]
      expect_any_instance_of(app).to receive(:erb).with(*success_erb_params)
      expect(messanger_double).to receive(:send_message).with({from_number: "111", to_number: "222", body: "lorem"}).
          and_return(true)

      post '/send_message', {account_id: "accountid", auth_id: "authid", from_number: "111", to_number: "222", body: "lorem"}
    end

    it "should return failure when post message is NOT successful" do
      success_erb_params= [:index, locals: {account: {account_id: "accountid", auth_id: "authid"}, error_flash: "ERROR FLASH"}]
      expect_any_instance_of(app).to receive(:erb).with(*success_erb_params)
      expect(messanger_double).to receive(:send_message).with({from_number: "", to_number: "", body: "lorem"}).
          and_return(false)

      post '/send_message', {account_id: "accountid", auth_id: "authid", from_number: "", to_number: "", body: "lorem"}
    end
  end
end
