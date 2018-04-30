require_relative 'boot'

# Libraries
require_relative 'tykee/tykee'

require_relative 'rails_mock'

# Application
require_relative '../app/routes'

Dir[File.expand_path("../app/intializers/*.rb")].each { |file| require file }
