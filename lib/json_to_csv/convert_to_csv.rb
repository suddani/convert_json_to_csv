# frozen_string_literal: true

# Converting json stream to csv stream
module JsonToCsv
  def self.enity_to_array(entity, keys)
    keys.map do |key|
      if key.end_with?('_at')
        Date.parse(entity[key]).to_s
      else
        entity[key]
      end
    end
  end

  def self.should_output?(filter, data)
    return true unless filter

    filter[1].include?(data[filter[0].to_s].to_s)
  end

  def self.get_keys(data, output:)
    keys = data.keys
    output&.puts CSV.generate_line(keys)
    keys
  end

  def self.convert_to_csv(input, output, keys: nil, filter: nil, header: true)
    output.puts CSV.generate_line(keys) if keys && header
    input.each_line do |line|
      data = JSON.parse(line)
      keys ||= get_keys(data, output: header ? output : nil)
      entry = enity_to_array(data, keys)
      output.puts CSV.generate_line(entry) if should_output?(filter, data)
    end
    nil
  end
end
