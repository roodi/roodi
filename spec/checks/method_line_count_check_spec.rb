require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Roodi::Checks::MethodLineCountCheck do
  before(:each) do
    @roodi = Roodi::Core::Runner.new(Roodi::Checks::MethodLineCountCheck.new)
  end
  
  it "should accept methods with zero lines" do
    content = <<-END
    def zero_line_method
    end
    END
    @roodi.check_content(content)
    @roodi.errors.should be_empty
  end

  it "should accept methods with five lines" do
    content = <<-END
    def five_line_method
      1
      2
      3
      4
      5
    end
    END
    @roodi.check_content(content)
    @roodi.errors.should be_empty
  end

  it "should reject methods with more than five lines" do
    content = <<-END
    def six_line_method
      1
      2
      3
      4
      5
      6
    end
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].should eql("dummy-file.rb:1 - Method name \"six_line_method\" has 6 lines.  It should have 5 or less.")
  end
end
