require 'rack'

require_relative 'lib/application'

# Public Assets
use Rack::Static, urls: ['/assets']
use Rack::Static, urls: {'/' => 'assets/index.html'}

run Tykee.rack
