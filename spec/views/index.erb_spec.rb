RSpec.describe 'index.erb', type: :view do
  before :each do
    app.get("/test") do erb :index; end
    def body
      get("/test").body
    end
  end

  it 'should contain title' do
    expect(body).to have_text('Twilio Messaging Interface')
  end

  it 'should contain account_id and auth_id input fields' do
    expect(body).to have_selector('input[type="text"][name="account_id_main"]')
    expect(body).to have_selector('input[type="text"][name="auth_id_main"]')
  end

  context 'send message form' do
    it 'should exist' do
      expect(body).to have_selector('form[action="send_message"][method="post"]')
    end

    it 'should contain all input fields' do
      expect(body).to have_selector('input[name="account_id"]', visible: false)
      expect(body).to have_selector('input[name="auth_id"]', visible: false)
      expect(body).to have_selector('input[type="text"][name="from_number"]')
      expect(body).to have_selector('input[type="text"][name="to_number"]')
      expect(body).to have_selector('textarea[name="body"]')
    end

    it 'should contain submit' do
      expect(body).to have_button("Send")
    end
  end

  context 'list messages refresh' do
    it 'should load refresh_form partial' do
      expect_any_instance_of(Sinatra::Application).to receive(:render_erb_partial).with(:"partials/refresh_form")
      body
    end
  end

  context 'with flash messages' do
    let(:body_with_flash) do
      app.get("/test_with_flash") do
        erb(:index, locals: {success_flash: "SUCCESS FLASH", error_flash: "ERROR FLASH"})
      end
      get("/test_with_flash").body
    end
    it 'should show success flash' do
      expect(body_with_flash).to have_selector('[class="success_flash"]')
    end
    it 'should show error flash' do
      expect(body_with_flash).to have_selector('[class="error_flash"]')
    end
  end

  context 'without flash messages' do
    let(:body_without_flash) do
      app.get("/test_without_flash") do
        erb(:index, locals: {})
      end
      get("/test_without_flash").body
    end
    it 'should not show success flash' do
      expect(body_without_flash).not_to have_selector('[class="success_flash"]')
    end
    it 'should not show error flash' do
      expect(body_without_flash).not_to have_selector('[class="error_flash"]')
    end
  end

end
