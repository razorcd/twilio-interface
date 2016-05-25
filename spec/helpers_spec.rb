class TestHelpers; include Helpers; end

describe "Helpers" do
  let(:helpers) { TestHelpers.new }
  let(:params) do
    {
      "account_id" => "xxxx",
      "auth_id" => "zzzz",
      "from_number" => "+1234512345",
      "to_number" => "+5678956789",
      "body" => "Lorem ipsum",
      "fake_field" => "This is fake",
    }
  end

  context "strong_send_message_params method" do
    it "should filter params" do
      expect(helpers.strong_send_message_params(params)).to eq({
        account_id: "xxxx",
        auth_id: "zzzz",
        from_number: "+1234512345",
        to_number: "+5678956789",
        body: "Lorem ipsum",
      })
      expect(helpers.strong_send_message_params(params)[:fake_field]).to eq nil
    end
  end

  context "strong_list_messages_params method" do
    it "should filter params" do
      expect(helpers.strong_list_messages_params(params)).to eq({
        account_id: "xxxx",
        auth_id: "zzzz",
      })
      expect(helpers.strong_list_messages_params(params)[:body]).to eq nil
      expect(helpers.strong_list_messages_params(params)[:fake_field]).to eq nil
    end
  end
end
