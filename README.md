# Knowyourgems

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/knowyourgems`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'knowyourgems'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install knowyourgems

## Usage

  1) Lists all the gems you own, just provide your rubygems handle

	  Knowyourgems.name_of_your_gems “karanarora"
	  
	  ==> ["hash_multi_tool", "knowyourgems"]

  2) Lists no. of gems you own, just provide your rubygems handle

	  Knowyourgems.your_total_gems “karanarora"
      	  
      ==> 2

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/karanarora/knowyourgems/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

