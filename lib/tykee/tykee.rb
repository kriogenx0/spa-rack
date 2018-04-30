require_relative 'router'

module Tykee

  extend Tykee::Router

  class << self

    def rack
      self.new
    end

    def new
      @server
    end

  end

  # For "use" keyword in config.ru
  def initialize app = nil
  end

end
