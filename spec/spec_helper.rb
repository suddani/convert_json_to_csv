# frozen_string_literal: true

require 'json_to_csv'

class HashArrayReader
  def initialize(data)
    @data = data
  end

  def each_line(&block)
    @data.each do |entry|
      block.call(entry.to_json)
    end
  end
end

class DirectReader
  def initialize(data)
    @data = data
  end

  def each_line(&block)
    @data.each do |entry|
      block.call(entry)
    end
  end
end

class Printer
  def puts(data)
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
