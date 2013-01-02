require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Roodi::Checks::ClassNameCheck do
  before(:each) do
    @roodi = Roodi::Core::Runner.new(Roodi::Checks::ClassNameCheck.make)
  end
  
  it "should accept camel case class names starting in capitals" do
    content = <<-END
    class GoodClassName 
    end
    END
    @roodi.check_content(content)
    @roodi.errors.should be_empty
  end

  it "should be able to parse scoped class names" do
    content = <<-END
    class MyScope::GoodClassName 
      def method
      end
    end
    END
    # @roodi.print_content(content)
    @roodi.check_content(content)
    @roodi.errors.should be_empty
  end

  it "should reject class names with underscores" do
    content = <<-END
    class Bad_ClassName 
    end
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("dummy-file.rb:1 - Class name \"Bad_ClassName\" should match pattern /^[A-Z][a-zA-Z0-9]*$/")
  end
end
