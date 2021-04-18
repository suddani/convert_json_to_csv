# frozen_string_literal: true

module ConvertJsonToCsv
  # Wraps multiple output streams and fans out the puts command
  class MultiWrapper
    def initialize(*outputs)
      @outputs = outputs.flatten
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
