require 'json'
require_relative 'rack_attack'

class RackApp::Api < RackAttack

  # We can start implementing the logic of our API here
  def main resource_name, resource_method
    render_json({
      resource_name: resource_name,
      resource_method: resource_method,
      post_body: post_params,
      get_params: get_params
    })
  end

end
