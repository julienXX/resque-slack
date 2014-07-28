Resque Slack
============

A [Resque][rq] plugin. Requires Resque >= 1.19 and a >= 1.9 Ruby (MRI, JRuby or Rubinius).

Post a notification in a [Slack][slack] channel when one your jobs fails.

## Installation

Add this line to your application's Gemfile:

    gem 'resque-slack'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install resque-slack

## Usage

Configure your channel and token:
```ruby
require 'resque/failure/slack'

Resque::Failure::Slack.configure do |config|
  config.channel = 'CHANNEL_ID'
  config.token = 'TEAM_TOKEN'
end

Resque::Failure.backend = Resque::Failure::Slack

```
NB: Your team token is found [here](https://api.slack.com/#auth)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[rq]: http://github.com/julienXX/resque
[slack]: http://slack.com

[![Build Status](https://travis-ci.org/julienXX/resque-slack.png)](https://travis-ci.org/julienXX/resque-slack) [![Code Climate](https://codeclimate.com/github/julienXX/resque-slack.png)](https://codeclimate.com/github/julienXX/resque-slack)
