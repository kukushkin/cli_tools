# Tools for a CLI application

A collection of helper methods for ruby CLI applications.

- `sh` — shell command execution, with output capturing
- `putr` — like `puts`, but erases current line and does not advance to a new line, invaluable for displaying things like progress bar
- `esc_...` — ANSI colors for your output
- `kb_getkey` — get the f.. key pressed in a non-blocking way
- and other little friends

## Requirements

You probably need a Unix based system to find this gem useful. The gem methods are tested and working on Mac OS X and Linux systems, and it is not guaranteed to work on Windows (especially because the console input/output is done the unix way).

## Installation

Add this line to your application's Gemfile:

    gem 'cli_tools'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cli_tools

## Usage

Keep all helper methods in CliTools namespace:
```ruby
require 'cli_tools'

puts CliTools.esc_green("Hello")+' world!' # outputs 'Hello world!' where 'Hello' is painted green
```

OR: have all the methods automatically included:

```ruby
require 'cli_tools/include' # equivalent to:
                            # require 'cli_tools'
                            # include CliTools

puts esc_green("Hello")+' world!'
```

### Try it out
```
cd examples/
ruby ex-ansi.rb
```


## TODO
- add more specs
- write comprehensive docs


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
