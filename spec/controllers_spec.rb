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

  context "POST '/list_messages'" do
    let(:messanger_double) {instance_double(Messanger)}

    before :each do
      class_double(Messanger)
      expect(Messanger).to receive(:new).with({account_id: "secret_accountid_12345", auth_id: "secret_authid_12345"}).and_return(messanger_double)
    end

    context "with valid params" do
      before :each do
        expect(messanger_double).to receive(:list_messages).and_return("data")
        expect_any_instance_of(app).to receive(:erb).
          with(:index, locals: {account: {account_id: "secret_accountid_12345", auth_id: "secret_authid_12345", from_number: "111", to_number: "222", body: "lorem"}, message_list: "data"}).
          and_return("data")
      end
      it "should return message list" do
        post '/list_messages', {account_id: "secret_accountid_12345", auth_id: "secret_authid_12345", from_number: "111", to_number: "222", body: "lorem"}
        expect(last_response.body).to eq("data")
      end

      it "should not display credentials in logs" do
        steal_logger!

        post '/list_messages', {account_id: "secret_accountid_12345", auth_id: "secret_authid_12345", from_number: "111", to_number: "222", body: "lorem"}

        expect(app.logger.log).not_to include "secret_accountid_12345"
        expect(app.logger.log).not_to include "secret_authid_12345"

        release_logger!
      end
    end

    context "with invalid params" do
      it "should NOT return message list" do
        expect(messanger_double).to receive(:list_messages).and_return(nil)
        expect(messanger_double).to receive(:error_message).and_return("ERROR MESSAGE")
        expect_any_instance_of(app).to receive(:erb).
          with(:index, locals: {account: {account_id: "secret_accountid_12345", auth_id: "secret_authid_12345", from_number: "111", to_number: "222", body: "lorem"}, flash: {error_flash: "ERROR MESSAGE"}}).
          and_return("data")

        post '/list_messages', {account_id: "secret_accountid_12345", auth_id: "secret_authid_12345", from_number: "111", to_number: "222", body: "lorem"}
        expect(last_response.body).to eq("data")
      end
    end
  end

  context "POST '/send_message'" do
    let(:messanger_double) { instance_double(Messanger) }

    before :each do
      class_double(Messanger)
      expect(Messanger).to receive(:new).with({account_id: "secret_accountid_12345", auth_id: "secret_authid_12345"}).and_return(messanger_double)
    end

    context "with valid params" do
      before (:each) do
        expect(messanger_double).to receive(:send_message).with({from_number: "111", to_number: "222", body: "lorem"}).
            and_return(true)
        expect_any_instance_of(app).to receive(:erb).
          with(:index, locals: {account: {account_id: "secret_accountid_12345", auth_id: "secret_authid_12345", from_number: "111", to_number: "222", body: ""}, flash: {success_flash: "Message was sent successfully."}}).
          and_return("data")
      end

      it "should post message" do
        post '/send_message', {account_id: "secret_accountid_12345", auth_id: "secret_authid_12345", from_number: "111", to_number: "222", body: "lorem"}
        expect(last_response.body).to eq("data")
      end

      it "should not display credentials in logs" do
        steal_logger!

        post('/send_message', {account_id: "secret_accountid_12345", auth_id: "secret_authid_12345", from_number: "111", to_number: "222", body: "lorem"})

        expect(app.logger.log).not_to include "secret_accountid_12345"
        expect(app.logger.log).not_to include "secret_authid_12345"

        release_logger!
      end
    end

    context "with invalid params" do
      it "should NOT post message" do
        expect(messanger_double).to receive(:send_message).with({from_number: "111", to_number: "222", body: "lorem"}).
            and_return(false)
        expect_any_instance_of(app).to receive(:erb).
          with(:index, locals: {account: {account_id: "secret_accountid_12345", auth_id: "secret_authid_12345", from_number: "111", to_number: "222", body: "lorem"}, flash: {error_flash: "Message sending failed."}}).
          and_return("data")

        post '/send_message', {account_id: "secret_accountid_12345", auth_id: "secret_authid_12345", from_number: "111", to_number: "222", body: "lorem"}
        expect(last_response.body).to eq("data")
      end
    end
  end
end
