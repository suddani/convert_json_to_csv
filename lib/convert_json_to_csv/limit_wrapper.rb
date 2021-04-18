# frozen_string_literal: true

module ConvertJsonToCsv
  # Wraps an output stream and only allows limited number of puts
  class LimitWrapper
    def initialize(io, limit, header)
      @io = io
      @limit = limit + (header ? 1 : 0)
      @count = 0
    end

    def puts(data)
      return should_exit! if @count >= @limit

      out = @io.puts data
      @count += 1
      return should_exit! if @count >= @limit

      out
    end

    def close
      @io.close
    end

    def should_exit!
      exit
    end
  end
end
