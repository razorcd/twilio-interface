require 'tilt/erb'

module Helpers
  # e.g.: <%= render_erb_partial :"partials/refresh_form", :locals => {name: "lorem ipsum"} %>
  def render_erb_partial(*args)
    render :erb, *args, layout: false
  end
end

helpers Helpers if defined? helpers
