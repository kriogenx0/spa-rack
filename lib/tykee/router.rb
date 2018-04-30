require_relative 'server'

module Tykee
  module Router

    attr_accessor :server

    # Define routes
    def routes &block
      @server ||= Tykee::RackServer.new
      instance_eval &block
    end

    # Create route
    def route pattern, &block
      @server.add_middleware pattern, block
    end

    def root &block
      route '/', &block
    end

    def querystring
      @server.get_params
    end

    def body
      @server.post_params
    end

  end
end
