RSpec.describe 'partials/refresh_form.erb', type: :view do
  let(:body) do
    app.get("/test") do erb("partials/refresh_form".to_sym, locals: {account: {}}); end
    get("/test").body
  end

  let(:body_with_credentials) do
    app.get("/test_with_credentials") do erb("partials/refresh_form".to_sym, locals: {account: {account_id: "account_id", auth_id: "auth_id"}}); end
    get("/test_with_credentials").body
  end

  it 'should exist' do
    expect(body).to have_selector('form[action="list_messages"][method="get"]')
  end

  it 'should contain all input fields' do
    expect(body).to have_selector('input[name="account_id"]', visible: false)
    expect(body).to have_selector('input[name="auth_id"]', visible: false)
  end

  it 'should contain credentials input fields' do
    expect(body_with_credentials).to have_selector('input[name="account_id"][value="account_id"]', visible: false)
    expect(body_with_credentials).to have_selector('input[name="auth_id"][value="auth_id"]', visible: false)
  end

  it 'should contain submit' do
    expect(body).to have_button("Refresh")
  end
  end
