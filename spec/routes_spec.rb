require File.expand_path '../spec_helper.rb', __FILE__

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
end
