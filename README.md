# Rubyfuza 2014

I'll fix this up as soon as I get a chance!

## The Birds and the Bees

The birds and the bees is a simple gem to illustrate how to use an ant algorithm to perform data clustering.
Data clustering is simply the grouping of similar items and the separation of dissimilar items.

Ants was written for RubyFuza 2014 in Cape Town, South Africa, and among other things, illustrates a practical computational intelligence algorithm and the joy of programming in metaphors.

## Installation

Add this line to your application's Gemfile:

    gem 'ants'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ants

## Usage

* Install the gem and `cd` to it's source
* `$ bundle exec config/create_users.rb` to generate random users with interests
* Try it out with:

```
#!/usr/bin/env ruby

require 'ants'
simulation = Ants::Sim::Simulation.new
simulation.start
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
