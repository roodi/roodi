require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Roodi::Checks::MethodLineCountCheck do
  before(:each) do
    @roodi = Roodi::Core::ParseTreeRunner.new(Roodi::Checks::MethodLineCountCheck.new(1))
  end
  
  it "should accept methods with less lines than the threshold" do
    pending "Support from ParseTree for newlines in methods"
    content = <<-END
    def zero_line_method
    end
    END
    @roodi.check_content(content)
    @roodi.errors.should be_empty
  end

  it "should accept methods with the same number of lines as the threshold" do
    pending "Support from ParseTree for newlines in methods"
    content = <<-END
    def one_line_method
      1
    end
    END
    @roodi.check_content(content)
    @roodi.errors.should be_empty
  end

  it "should reject methods with more lines than the threshold" do
    pending "Support from ParseTree for newlines in methods"
    content = <<-END
    def two_line_method
      1
      2
    end
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].should eql("dummy-file.rb - Method name \"two_line_method\" has 2 lines.  It should have 1 or less.")
  end
end
