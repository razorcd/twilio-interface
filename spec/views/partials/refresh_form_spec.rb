RSpec.describe 'partials/refresh_form.erb', type: :view do
  let(:refresh_form_without_credentials_body) do
    app.get("/test_refresh_form_without_credentials") do erb("partials/refresh_form".to_sym, locals: {account: {}}); end
    get("/test_refresh_form_without_credentials").body
  end

  let(:refresh_form_with_credentials_body) do
    app.get("/test_refresh_form_with_credentials") do erb("partials/refresh_form".to_sym, locals: {account: {account_id: "account_id", auth_id: "auth_id"}}); end
    get("/test_refresh_form_with_credentials").body
  end

  it 'should exist' do
    expect(refresh_form_without_credentials_body).to have_selector('form[action="list_messages"][method="get"]')
  end

  it 'should contain all input fields' do
    expect(refresh_form_without_credentials_body).to have_selector('input[name="account_id"]', visible: false)
    expect(refresh_form_without_credentials_body).to have_selector('input[name="auth_id"]', visible: false)
  end

  it 'should contain credentials input fields' do
    expect(refresh_form_with_credentials_body).to have_selector('input[name="account_id"][value="account_id"]', visible: false)
    expect(refresh_form_with_credentials_body).to have_selector('input[name="auth_id"][value="auth_id"]', visible: false)
  end

  it 'should contain submit' do
    expect(refresh_form_without_credentials_body).to have_button("Refresh")
  end
end
