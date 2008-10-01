require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Roodi::Checks::CyclomaticComplexityBlockCheck do
  before(:each) do
    @roodi = Roodi::Core::ParseTreeRunner.new(Roodi::Checks::CyclomaticComplexityBlockCheck.new({'complexity' => 0}))
  end

  def verify_content_complexity(content, complexity)
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("dummy-file.rb:2 - Block cyclomatic complexity is #{complexity}.  It should be 0 or less.")
  end
  
  it "should find a simple block" do
    content = <<-END
    def method_name
      it "should be a simple block" do
        call_foo
      end
    end
    END
    verify_content_complexity(content, 1)
  end

  it "should find a block with multiple paths" do
    content = <<-END
    def method_name
      it "should be a complex block" do
        call_foo if some_condition
      end
    end
    END
    verify_content_complexity(content, 2)
  end
end
