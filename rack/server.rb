ROOT = File.dirname File.dirname(__FILE__)

module RackApp
  class Server
    def initialize
    end
    def call(env)
      # Anything else should go to SPA, error handling will be done by SPA
      # status, headers, content
      [200, {'Content-Type' => 'text/html'}, [index_page]]
    end

    def index_page
      @index_page ||= File.read(File.join(ROOT, 'assets/index.html'))
    end
  end
end
