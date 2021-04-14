# frozen_string_literal: true

require 'csv'
require 'time'
require 'json'
require 'optparse'

require_relative "json_to_csv/convert_to_csv"
require_relative "json_to_csv/find_all_keys"
require_relative "json_to_csv/limit_wrapper"
require_relative "json_to_csv/multi_wrapper"
require_relative "json_to_csv/stdout_wrapper"
require_relative "json_to_csv/parser"

module JsonToCsv
  class Error < StandardError; end
  # Your code goes here...
end