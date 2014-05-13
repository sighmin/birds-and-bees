# Rubyfuza 2014

Computational Intelligence code for data clustering, a code example of the
presentation given at [Ruby Fuza 2014](http://rubyfuza.org).


## The Birds and the Bees

*ants* is a simple gem to illustrate how to use an ant algorithm to perform data
clustering. Data clustering is simply the grouping of similar items and the
separation of dissimilar items.

The AI model is inspired by the natural clustering phenomenon performed by ants
on their dead, called Cemetery Formation. This implementation is based on the
lumer-feita algorithm for data clustering of heterogeneous data items.

Ants was written for RubyFuza 2014 in Cape Town, South Africa, and among other
things, illustrates a practical computational intelligence algorithm and the joy
of programming in metaphors.


## Installation

Grab the code from github:

```
$ git clone git@github.com:sighmin/birds-and-bees.git
```


## Usage

** Install the gem and `cd` to it's source **

There is a sample script that can be run as follows:

```
$ bundle exec ruby bin/simulate
```

Note: You'll only have to generate the data once, but the script is included
to see how the ants behave when they encounter various levels of 'heterogeneity'
(data that is more different than one another)

To try out a new data set, remove the old one and modify the `bin/generate`.
Run `bin/simulate` again as above to recreate the datafile.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## License

Copyright (c) 2014 Simon van Dyk

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
