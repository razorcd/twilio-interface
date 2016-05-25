require 'tilt/erb'

module Helpers
  def strong_send_message_params params
    {
      account_id: params["account_id"],
      auth_id: params["auth_id"],
      from_number: params["from_number"],
      to_number: params["to_number"],
      body: params["body"],
    }
  end

  def strong_list_messages_params params
    {
      account_id: params["account_id"],
      auth_id: params["auth_id"],
    }
  end

  # e.g.: <%= render_erb_partial :"partials/refresh_form", :locals => {name: "lorem ipsum"} %>
  def render_erb_partial(*args)
    render :erb, *args, layout: false
  end
end

helpers Helpers if defined? helpers
