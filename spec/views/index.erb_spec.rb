RSpec.describe '/index.erb', type: :view do
  let(:body) do
    app.get("/test") { erb :index };
    @body= get("/test").body
  end

  it 'should contain title' do
    expect(body).to match('Twilio Interface')
  end

  it 'should contain send message form' do
    expect(body).to match('form')
    expect(body).to match('action="/send_message"')
  end
end
