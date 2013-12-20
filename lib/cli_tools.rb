require "cli_tools/version"
require "cli_tools/console"
require "cli_tools/system"

module CliTools

  # Include all instance methods as module methods
  class << self
    include CliTools
  end
end
