# frozen_string_literal: true

module JsonToCsv
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
      @outputs.each do |output|
        output.close
      end
    end
  end
end
