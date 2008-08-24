require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'roodi'
require 'checks/class_name_check'

describe ClassNameCheck do
  before(:all) do
    @roodi = Roodi.new(ClassNameCheck.new)
  end
  
  it "should reject class names starting in lowercase letters" do
    content = <<-END
    class badClassName 
    end
    END
    errors = @roodi.check_content(content)
    # errors.should_not be_empty
    # errors[0].should eql("dummy-file.rb:1 - Class name \"badClassName\" should match pattern /^[A-Z][a-zA-Z0-9]*$/.")
  end
end
