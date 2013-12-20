require 'spec_helper'

describe CliTools do

  it "should provide VERSION" do
    CliTools.should be_const_defined(:VERSION)
    CliTools::VERSION.should be_a( String )
  end

  it { should respond_to(:putr) }
  it { should respond_to(:sh) }

end