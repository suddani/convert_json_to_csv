# frozen_string_literal: true

module ConvertJsonToCsv
  # Wraps an output streams and prevents the user from closing it
  class NoCloseWrapper
    def initialize(io)
      @io = io
    end

    def puts(data)
      @io.puts data
    end

    def close; end
  end
end
