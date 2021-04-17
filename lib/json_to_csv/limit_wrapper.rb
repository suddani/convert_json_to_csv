# frozen_string_literal: true

module JsonToCsv
  # Wraps multiple output streams and fans out the puts command
  class MultiWrapper
    def initialize(*outputs)
      @outputs = outputs
    end

    def puts(data)
      @outputs.each do |output|
        output.puts data
      end
    end

    def close
      @outputs.each(&:close)
    end
  end
end
