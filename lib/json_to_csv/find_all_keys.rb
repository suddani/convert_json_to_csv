# frozen_string_literal: true

# Extract all keys from a stream of json objects
module JsonToCsv
  def self.find_all_keys(input, output)
    all_keys = []
    input.each_line do |line|
      all_keys = (all_keys + JSON.parse(line).keys).uniq
    end
    all_keys.each do |key|
      output.puts key
    end
  end
end
