# frozen_string_literal: true

module JsonToCsv
  # Wraps an output stream and only allows limited number of puts
  class LimitWrapper
    def initialize(io, limit, header)
      @io = io
      @limit = limit + (header ? 1 : 0)
      @count = 0
    end

    def puts(data)
      out = @io.puts data
      @count += 1
      exit if @count >= @limit
      out
    end

    def close
      @io.close
    end
  end
end
