# Awis

A way to query Alexa's awis and ats services

## Installation

Clone this repo, install dependencies with `bundle install --path .bundle`

Can be installed as gem with
``` bash
bundle exec rake build
gem install pkg/aiws-{version}.gem
```

## Requirements
-   ruby 2.5.1
-   commander 4.4.6
-   nori 2.6.0
-   bundler ~> 1.16
-   rake ~> 10.0
-   rspec ~> 3.0


## Usage
The respective executables save the results of the AWS service in individual files on the given output path.
The intention is to be able to consult these results without needing to call AWS again.

The report generation is based on those result files.

There are two executable files

### awis
```
awis

Get sinformation from Alexa Web Information Services

Commands:
  help    Display global or [command] help documentation
  info    Gets data from UrlInfo action.
  traffic Gets data from trafficHistory Action.

Global Options:
  -h, --help           Display help documentation
  -v, --version        Display version information
  -t, --trace          Display backtrace when an error occurs
```
### ats

```
awis

ats

Get information from Alexa Top Sites

Commands:
  help       Display global or [command] help documentation
  list       Gets data from trafficHistory Action.
  top        Gets data from UrlInfo action.
  top_report Prints report CSV to standard out

Global Options:
  -h, --help           Display help documentation
  -v, --version        Display version information
  -t, --trace          Display backtrace when an error occurs


```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub [on this repo](https://github.com/gdledsan/awis). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Awis project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/gdledsan/awis/blob/master/CODE_OF_CONDUCT.md).
