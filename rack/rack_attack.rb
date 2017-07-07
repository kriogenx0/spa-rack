# RackAttack - A Restful Rack utility

class RackAttack
  def initialize(app = nil, options = {})
    @app = app
  end

  def call env
    @env = env
    return @app.call(env) unless env['REQUEST_PATH'] =~ /^\/api\//
    load_path env['PATH_INFO']
    @response or render_json 'error'
  end

  # Parse out Restful call
  # /api/:resource_name/:resource_method
  def load_path path
    url_matches = /^\/api\/(\w+)(\/\w+)?/.match path
    render_json 'error' unless url_matches
    resource_name = url_matches.captures[0]
    resource_method = url_matches.captures[1] || 'index'

    main resource_name, resource_method
  end

  # It's an API, we'll always be returning JSON
  def render_json json, status = 200
    @response = [status, {'Content-Type' => 'text/json', 'Cache-Control' => 'max-age=0'}, [json.to_json]]
  end

  private

  def post_body
    ::Rack::Utils.parse_query(@env['rack.input'].read, "&")
  end

  def get_params
    ::Rack::Utils.parse_query(@env['QUERY_STRING'], "&")
  end
end
