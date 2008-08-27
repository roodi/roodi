require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Roodi::Checks::CyclomaticComplexityCheck do
  before(:each) do
    @roodi = Roodi::Core::Runner.new(Roodi::Checks::CyclomaticComplexityCheck.new)
  end
  
  it "should find two paths at an if block" do
    content = <<-END
    def method_name
      if some_condition then
      end
    end
    END
    # @roodi.print_content(content)
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].should eql("dummy-file.rb:1 - Cyclomatic complexity is 2.  It should be 0 or less.")
  end

  it "should add nested if blocks together" do
    content = <<-END
    def method_name
      if first_condition then
        call_foo if second_condition
        call_bar if third_condition
      end
    end
    END
    # @roodi.print_content(content)
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].should eql("dummy-file.rb:1 - Cyclomatic complexity is 6.  It should be 0 or less.")
  end
end
