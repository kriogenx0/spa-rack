require 'json'

ROOT = File.expand_path '../../', __dir__

module Tykee
  class RackServer
    attr_accessor :middlewares

    def initialize app = nil
      @app = app
    end

    def call env
      @env = env
      run_middlewares || continue_pipeline
    end

    def continue_pipeline
      if @app
        @app.call @env
      else
        render nil, 404
      end
    end

    def add_middleware pattern, block
      @middlewares ||= {}
      @middlewares[pattern] = block
    end

    def run_middlewares
      result = nil
      @middlewares.each do |pattern, func|
        match = match_route pattern
        if match
          func_result = instance_eval &func
          result = render func_result
          # result = render func.call
          break
        end
      end
      result
    end

    def match_route pattern
      p1 = @env['REQUEST_PATH']
      if pattern.is_a? Regexp
        p1 =~ pattern
      else
        p1.include? pattern
      end
    end

    def render_file file
      render file
    end

    def render body
      if body.is_a? Hash
        body = body.to_json
      else
        type = 'html'
      end

      type ||= 'json'
      content_type = parse_type type
      body ||= ''

      # status, headers, body
      [status, {'Content-Type' => content_type}, [body]]
    end

    def index_page
      @index_page ||= File.read(File.join(ROOT, 'public/index.html'))
    end

    def parse_type type
      case type.to_sym
      when :html
        'text/html'
      else
        'text/json'
      end
    end

    def status status_value = nil
      if status_value
        @next_status = status_value
      else
        @next_status || 200
      end
    end

    def get
      req = Rack::Request.new @env
      if req.get?
        puts req.GET()
      end
    end

    def post
      req = Rack::Request.new @env
      if req.post?
        puts req.POST()
      end
    end

    def post_params
      ::Rack::Utils.parse_query(@env['rack.input'].read, "&")
    end

    def get_params
      ::Rack::Utils.parse_query(@env['QUERY_STRING'], "&")
    end
  end
end
