RSpec.describe 'index.erb', type: :view do
  let(:body) do
    app.get("/test") { erb :index };
    @body= get("/test").body
  end

  it 'should contain title' do
    expect(body).to have_text('Twilio Messaging Interface')
  end

  context 'send message form' do
    it 'should exist' do
      expect(body).to have_selector('form[action="send_message"][method="post"]')
    end

    it 'should contain all input fields' do
      expect(body).to have_selector('input[type="text"][name="email"]')
    end

    it 'should contain submit' do
      expect(body).to have_button("Send")
    end
  end
end
