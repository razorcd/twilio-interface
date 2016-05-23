module Helpers
  def self.strong_send_message_params params
    {
      account_id: params["account_id"],
      auth_id: params["auth_id"],
      from_number: params["from_number"],
      to_number: params["to_number"],
      body: params["body"],
    }
  end

  def self.strong_list_messages_params params
    {
      account_id: params["account_id"],
      auth_id: params["auth_id"],
    }
  end
end
