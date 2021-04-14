# frozen_string_literal: true

module JsonToCsv
  class Parser
    attr_accessor :file, :keys, :only_keys, :filter, :limit, :header, :std

    def initialize
      self.file = nil
      self.keys = nil
      self.only_keys = false
      self.filter = nil
      self.limit = nil
      self.header = true
      self.std = false
    end

    def file_output
      @file_output ||= std && file ? MultiWrapper.new(StdoutWrapper.new($stdout), file) : file
    end

    def output
      @output ||= limit ? LimitWrapper.new(file_output || StdoutWrapper.new($stdout), limit, header) : (file_output || StdoutWrapper.new($stdout))
    end

    def opt_parser
      @opt_parser ||= OptionParser.new do |opts|
        opts.banner = "Usage: convert_to_csv [options] FILE"

        opts.on("--[no-]stdout", "Print to stdout as well") do |std|
          self.std = std
        end

        opts.on("-o", "--output=OUTPUT", "Output file or print to std out") do |n|
          self.file = File.open(n, "w+")
        end

        opts.on("--[no-]header", "Output header line") do |header|
          self.header = header
        end

        opts.on("-k", "--keys=KEYS", Array, "Keys to use for csv. Comma seperated") do |keys|
          self.keys = keys
        end

        opts.on("--key-file FILE", "File containing keys one per line") do |key_file|
          self.keys = File.read(key_file).split("\n")
        end

        opts.on("--only-keys", "Only print keys") do |keys|
          self.header = false
          self.only_keys = true
        end

        opts.on("--filter-file FILE", "File containing filter") do |filter_file|
          self.filter = CSV.parse(File.read(filter_file), headers: true, header_converters: :symbol).reduce({}) {|r, row| {row.first[0] => (r[row.first[0]]||[]) + [row.first[1]].compact} }.to_a.first
        end

        opts.on("-f", "--filter FILTER", Array, "Filter by key,value0,value1,value2") do |filter|
          self.filter = [filter[0], filter[1..]]
        end

        opts.on("-l", "--limit LIMIT", Integer, "Limit output to LIMIT entries(equal or greater than 0)") do |limit|
          raise if limit < 0
          self.limit = limit
        end

        opts.on("-h", "--help", "Prints this help") do
          puts opts
          exit
        end
      end
    end

    def parse(options)
      opt_parser.parse!(options)
      return self
    rescue
      puts opt_parser
      nil
    end

    def self.run
      parser = new
      options = parser.parse ARGV

      if options && options.only_keys
        JsonToCsv.find_all_keys(ARGF, options.output)
      elsif options
        JsonToCsv.convert_to_csv(ARGF, options.output, keys: options.keys, filter: options.filter, header: options.header)
      end
    ensure
      options&.output&.close
    end
  end
end