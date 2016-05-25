RSpec.describe 'partials/refresh_form.erb', type: :view do
  let(:body) do
    app.get("/test") do erb subject.to_sym; end
    get("/test").body
  end

  it 'should exist' do
    expect(body).to have_selector('form[action="list_messages"][method="get"]')
  end

  it 'should contain all input fields' do
    expect(body).to have_selector('input[name="account_id"]', visible: false)
    expect(body).to have_selector('input[name="auth_id"]', visible: false)
  end

  it 'should contain submit' do
    expect(body).to have_button("Refresh")
  end
  end
