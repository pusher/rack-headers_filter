# Rack::HeadersFilter

Sanitizes some of the "trusted" headers. Useful when you don't control your
frontend router like on Heroku. This is the next best thing.

The are some funky heuristics happening inside of Rack::Request. For example
`request.ip` and `request.host_with_port` use HTTP_X_FORWARDED_HOST which is
forgeable by the client on Heroku. This is then trusted by other code like
`ActionController::ForceSSL` as a canonical source of truth. The result is
that if something can set the `X-Forwarded-Host` header, and `config.force_ssl
= true` is set in rails, the user gets redirected to that random host.

This middleware creates a list of "dangerous" headers that are used by
`Rack::Request` and filters out the ones that are not controlled by the
router. By default it is configured to be deployed on Heroku.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-headers_filter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-headers_filter

## Usage

This middleware is designed to be installed first in the chain. Either add
this to the `config.ru`:

```ruby
require 'rack/headers_filter'
use Rack::HeadersFilter
```

Or in `config/environments/production.rb`:

```ruby
# First thing, filter out bad headers (0 == first)
config.middleware.insert_before(0, Rack::HeadersFilter)
```

## Development

After checking out the repo, run `script/setup` to install dependencies. Then,
run `rake spec` to run the tests. You can also run `script/console` for an
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/pusher/rack-headers_filter.

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

