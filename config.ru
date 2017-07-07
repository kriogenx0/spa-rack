require 'rack'

require_relative 'rack/main'

# Public Assets
use Rack::Static, urls: ['/assets']
use Rack::Static, urls: {'/' => 'assets/index.html'}

# API
use RackApp::Api

# Rack::Handler.default.run SpaServer.new, Port: 3000 # doesnt work with "use"
run RackApp::Server.new
