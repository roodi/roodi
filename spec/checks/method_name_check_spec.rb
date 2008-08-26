require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'roodi'
require 'checks/method_name_check'

describe MethodNameCheck do
  before(:each) do
    @roodi = Roodi.new(MethodNameCheck.new)
  end
  
  it "should accept method names with underscores" do
    content = <<-END
    def good_method_name
    end
    END
    @roodi.check_content(content)
    @roodi.errors.should be_empty
  end

  it "should reject camel case method names" do
    content = <<-END
    def badMethodName
    end
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].should eql("dummy-file.rb:1 - Method name \"badMethodName\" should match pattern (?-mix:^[a-z_?=]*$).")
  end
end
