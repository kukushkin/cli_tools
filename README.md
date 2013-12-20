# Tools for CLI application

A collection of helper methods for ruby CLI application.

## Installation

Add this line to your application's Gemfile:

    gem 'cli_tools'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cli_tools

## Usage

```ruby
require 'cli_tools'
include CliTools

puts esc_green("Hello")+' world!' # outputs 'Hello world!' where 'Hello' is painted green
```

OR: all the methods automatically included into Kernel:

```ruby
require 'cli_tools/include'

puts esc_green("Hello")+' world!'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
