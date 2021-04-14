# frozen_string_literal: true

module JsonToCsv
  def self.convert_to_csv(input, output, keys: nil, filter: nil, header: true)
    output.puts CSV.generate_line(keys) if keys && header
    input.each_line do |line|
      data = JSON.parse(line)
      keys ||= begin
        k = data.keys
        output.puts CSV.generate_line(k) if header
        k
      end
      entry = keys.map do |key|
        if key.end_with?("_at")
          Date.parse(data[key]).to_s
        else 
          data[key]
        end
      end
      if !filter || filter[1].include?(data[filter[0].to_s].to_s)
        output.puts CSV.generate_line(entry)
      end
    end
    nil
  end
end
