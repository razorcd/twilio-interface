RSpec.describe 'index.erb', type: :view do
  before :each do
    @unique_id= rand(9999999999999999999)
    def set_rendered_with locals:
      app.get("/test_index_#{@unique_id}") do erb :index, locals: locals; end
    end

    def index_body
      get("/test_index_#{@unique_id}").body
    end
  end

  it 'should contain title' do
    set_rendered_with locals: {account: {}}

    expect(index_body).to have_text('Twilio Messaging Interface')
  end

  context 'send message form' do
    it 'should exist' do
      set_rendered_with locals: {account: {}}

      expect(index_body).to have_selector('form[action="send_message"][method="post"]')
    end


    it 'should contain all empty input fields' do
      set_rendered_with locals: {account: {}}

      expect(index_body).to have_selector('input[name="account_id"][value=""]')
      expect(index_body).to have_selector('input[name="auth_id"][value=""]')
      expect(index_body).to have_selector('input[type="text"][name="from_number"][value=""]')
      expect(index_body).to have_selector('input[type="text"][name="to_number"][value=""]')
      expect(index_body).to have_selector('textarea[name="body"][value=""]')
    end

    it 'should contain all filled input fields' do
      set_rendered_with locals: {account: {account_id: "accountid", auth_id: "authid", from_number: "111", to_number: "222", body: "lorem"}}

      expect(index_body).to have_selector('input[name="account_id"][value="accountid"]')
      expect(index_body).to have_selector('input[name="auth_id"][value="authid"]')
      expect(index_body).to have_selector('input[type="text"][name="from_number"][value="111"]')
      expect(index_body).to have_selector('input[type="text"][name="to_number"][value="222"]')
      expect(index_body).to have_selector('textarea[name="body"][value="lorem"]')
    end

    it 'should NOT autocomplete credential input fields' do
      set_rendered_with locals: {account: {}}

      expect(index_body).to have_selector('input[name="account_id"][autocomplete="off"]')
      expect(index_body).to have_selector('input[name="auth_id"][autocomplete="off"]')
    end

    it 'should contain submit' do
      set_rendered_with locals: {account: {}}

      expect(index_body).to have_button("Send")
    end
  end

  context 'list messages refresh' do
    it 'should load refresh_form partial' do
      allow_any_instance_of(Sinatra::Application).to receive(:render_erb_partial).with(:"partials/message_list", locals: {message_list: []})
      set_rendered_with locals: {account: {}}

      expect_any_instance_of(Sinatra::Application).to receive(:render_erb_partial).with(:"partials/refresh_form", locals: {account: {}})
      index_body
    end
  end

  context 'list messages table' do
    it 'should load message_list partial if message_list exists' do
      allow_any_instance_of(Sinatra::Application).to receive(:render_erb_partial).with(:"partials/refresh_form", locals: {account: {}})
      set_rendered_with locals: {account: {}, message_list: []}

      expect_any_instance_of(Sinatra::Application).to receive(:render_erb_partial).with(:"partials/message_list", locals: {message_list: []})
      index_body
    end

    it 'should NOT load message_list partial if no message_list exists' do
      allow_any_instance_of(Sinatra::Application).to receive(:render_erb_partial).with(:"partials/refresh_form", locals: {account: {}})
      set_rendered_with locals: {account: {}}

      expect_any_instance_of(Sinatra::Application).not_to receive(:render_erb_partial).with(:"partials/message_list", locals: {account: {}})
      index_body
    end
  end




  context 'with flash messages' do
    let(:body_with_flash) do
      app.get("/test_index_with_flash") do
        erb(:index, locals: {account: {}, flash: {success_flash: "SUCCESS FLASH", error_flash: "ERROR FLASH"}})
      end
      get("/test_index_with_flash").body
    end

    it 'should load flash partial' do
      allow_any_instance_of(Sinatra::Application).to receive(:render_erb_partial).with(:"partials/refresh_form", locals: {account: {}})
      expect_any_instance_of(Sinatra::Application).to receive(:render_erb_partial).
          with(:"partials/flash", locals: {flash: {success_flash: "SUCCESS FLASH", error_flash: "ERROR FLASH"}})

      body_with_flash
    end
  end

  context 'without flash messages' do
    let(:body_without_flash) do
      app.get("/test_index_without_flash") do
        erb(:index, locals: {account: {}})
      end
      get("/test_index_without_flash").body
    end

    it 'should not load flash partial' do
      allow_any_instance_of(Sinatra::Application).to receive(:render_erb_partial).with(:"partials/refresh_form", locals: {account: {}})
      expect_any_instance_of(Sinatra::Application).not_to receive(:render_erb_partial).
          with(:"partials/flash", locals: {})

      body_without_flash
    end
  end

end
