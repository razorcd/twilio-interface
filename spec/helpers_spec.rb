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
end
