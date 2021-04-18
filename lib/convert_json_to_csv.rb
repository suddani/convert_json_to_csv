# frozen_string_literal: true

require 'csv'
require 'time'
require 'json'
require 'optparse'

require_relative 'convert_json_to_csv/convert_to_csv'
require_relative 'convert_json_to_csv/find_all_keys'
require_relative 'convert_json_to_csv/limit_wrapper'
require_relative 'convert_json_to_csv/multi_wrapper'
require_relative 'convert_json_to_csv/no_close_wrapper'
require_relative 'convert_json_to_csv/parser'

# Wraps all json to csv related classes and functions
module ConvertJsonToCsv
  class Error < StandardError; end
  # Your code goes here...
end
