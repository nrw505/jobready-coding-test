# Jobready::Coding::Test

This is my submission for the JobReady coding test.

One thing to note:

This does not pass the examples as given. The examples as given
require an input of "music cd" to produce an output of "music CD" and
an input of "box of imported chocolates" to produce an output of
"imported box of chocolates". I have assumed for now that rewriting of
line item descriptions is not intended - if that assumption is
incorrect then let's talk more about the rules for that rewriting: I
think that's a bigger problem that needs more specification around it.

## Installation

You probably don't want to actually install this. But if you do, add this line to your application's Gemfile:

```ruby
gem 'jobready-coding-test'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install jobready-coding-test

## Usage

Once installed, you will have a program `process-basket-csv` which
takes two arguments: input and output. These can either be filenames
or `-` which will read or write to standard I/O.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nrw505/jobready-coding-test. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/nrw505/jobready-coding-test/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Jobready::Coding::Test project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/nrw505/jobready-coding-test/blob/master/CODE_OF_CONDUCT.md).
