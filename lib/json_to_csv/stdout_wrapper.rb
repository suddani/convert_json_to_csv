module JsonToCsv
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
