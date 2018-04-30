# Rails Mock

class Rails
  class << self
    def root
      File.dirname File.dirname(__FILE__)
    end

    def env
      self
    end

    def production?
      true
    end

    def development?
      false
    end
  end
end
