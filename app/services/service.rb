module Service
  class Base
    attr_reader :result, :errors

    def initialize(**args)
      args.each { |k, v| instance_variable_set("@#{k}", v) }
      @errors = []
    end

    def self.call(**args)
      new(**args).execute
    end

    def execute
      @result = call
      self
    end

    def error
      errors.first
    end

    def successful?
      errors.empty?
    end

    private

    def append_error(type, message)
      errors << ::Service::Error.new(type, message)
    end
  end

  class Error
    attr_reader :type, :message

    def initialize(type, message)
      @type = type
      @message = message
    end
  end
end
