require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Roodi::Checks::ClassVariableCheck do
  before(:each) do
    @roodi = Roodi::Core::ParseTreeRunner.new(Roodi::Checks::ClassVariableCheck.new)
  end
  
  it "should reject class variables" do
    content = <<-END
    @@foo
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("dummy-file.rb:1 - Don't use class variables. You might want to try a different design.")
  end
end
