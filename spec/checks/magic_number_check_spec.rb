require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'roodi'
require 'checks/magic_number_check'

describe MagicNumberCheck do
  before(:each) do
    @roodi = Roodi.new(MagicNumberCheck.new)
  end
  
  it "should accept -1 as a non-magic number" do
    errors = @roodi.check_content("-1")
    errors.should be_empty
  end

  it "should accept 0 as a non-magic number" do
    errors = @roodi.check_content("0")
    errors.should be_empty
  end

  it "should accept 1 as a non-magic number" do
    errors = @roodi.check_content("1")
    errors.should be_empty
  end

  it "should accept 2 as a non-magic number" do
    errors = @roodi.check_content("2")
    errors.should be_empty
  end

  it "should accept numbers in the FixNum range that are magic, but are assigned to a constant" do
    pending "MagicNumberCheck needs to look at the parent node to see if it is being assigned"
    errors = @roodi.check_content("VALUE = 3")
    errors.should be_empty
  end

  it "should reject numbers in the FixNum range that are magic" do
    errors = @roodi.check_content("3")
    errors.should_not be_empty
    errors[0].should eql("dummy-file.rb:1 - 3 is a magic number.  Use a meaningful constant or variable instead.")
  end

  it "should reject numbers in the BigNum range that are magic" do
    errors = @roodi.check_content("1234567890123456789012345678901234567890")
    errors.should_not be_empty
    errors[0].should eql("dummy-file.rb:1 - 1234567890123456789012345678901234567890 is a magic number.  Use a meaningful constant or variable instead.")
  end
end
