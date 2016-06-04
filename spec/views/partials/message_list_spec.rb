RSpec.describe 'partials/message_list.erb', type: :view do
  let(:message_list_without_messages_body) do
    app.get("/test_message_list_without_messages_body") do erb("partials/message_list".to_sym, locals: {message_list: []}); end
    get("/test_message_list_without_messages_body").body
  end

  let(:message_list_with_messages_body) do
    app.get("/test_message_list_with_messages_body") do
      erb("partials/message_list".to_sym, locals: {message_list: [{"date_sent" => "1 may 2016", "to" => "+1", "from" => "+2", "body" => "Lorem Ipsum"}]})
    end
    get("/test_message_list_with_messages_body").body
  end

  it 'contain a table' do
    expect(message_list_without_messages_body).to have_selector('table')
  end

  it 'should contain table headers' do
    expect(message_list_without_messages_body).to have_selector('th', :text => "Date Sent")
    expect(message_list_without_messages_body).to have_selector('th', :text => "To")
    expect(message_list_without_messages_body).to have_selector('th', :text => "From")
    expect(message_list_without_messages_body).to have_selector('th', :text => "Body")
  end

  it 'should contain messages when message_list has messages' do
    expect(message_list_with_messages_body).to have_selector('td', :text => "1 may 2016")
    expect(message_list_with_messages_body).to have_selector('td', :text => "+1")
    expect(message_list_with_messages_body).to have_selector('td', :text => "+2")
    expect(message_list_with_messages_body).to have_selector('td', :text => "Lorem Ipsum")
  end

  it 'should NOT contain messages when message_list has no messages' do
    expect(message_list_without_messages_body).not_to have_selector('table tbody td')
  end

  end
