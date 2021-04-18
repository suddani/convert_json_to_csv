# ConvertJsonToCsv

This programm is ment as a small shel programm that converts json stream files to csv files. 

It works with the standard input if no input file is given.
## Installation

```
gem install convert_json_to_csv
```

## Usage

```
Usage: convert_to_csv [options] FILE
        --[no-]stdout                Print to stdout as well
    -o, --output=OUTPUT              Output file or print to std out
        --[no-]header                Output header line
    -k, --keys=KEYS                  Keys to use for csv. Comma seperated
        --key-file FILE              File containing keys one per line
        --only-keys                  Only print keys
        --filter-file FILE           File containing filter
    -f, --filter FILTER              Filter by key,value0,value1,value2
    -l, --limit LIMIT                Limit output to LIMIT entries(equal or greater than 0)
    -h, --help                       Prints this help
```

## Installation as dependency

Add this line to your application's Gemfile:

```ruby
gem 'convert_json_to_csv'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install convert_json_to_csv
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/convert_json_to_csv. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/convert_json_to_csv/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ConvertJsonToCsv project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/convert_json_to_csv/blob/master/CODE_OF_CONDUCT.md).
