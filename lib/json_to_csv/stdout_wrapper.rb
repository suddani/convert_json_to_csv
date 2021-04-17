# frozen_string_literal: true

module JsonToCsv
  # Wraps an output streams and prevents the user from closing it
  class StdoutWrapper
    def initialize(io)
      @io = io
    end

    def puts(data)
      @io.puts data
    end

    def close; end
  end
end
