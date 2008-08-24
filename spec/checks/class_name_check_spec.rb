require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'roodi'
require 'checks/class_name_check'

describe ClassNameCheck do
  before(:each) do
    @roodi = Roodi.new(ClassNameCheck.new)
  end
  
  it "should accept camel case class names starting in capitals" do
    content = <<-END
    class GoodClassName 
    end
    END
    errors = @roodi.check_content(content)
    errors.should be_empty
  end

  it "should reject class names with underscores" do
    content = <<-END
    class Bad_ClassName 
    end
    END
    errors = @roodi.check_content(content)
    errors.should_not be_empty
    errors[0].should eql("dummy-file.rb:1 - Class name \"Bad_ClassName\" should match pattern (?-mix:^[A-Z][a-zA-Z0-9]*$).")
  end
end
