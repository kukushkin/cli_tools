require 'spec_helper'
require 'cli_tools/include'

describe "when included, main object" do
  it { should respond_to(:putr) }
  it { should respond_to(:sh) }
end
