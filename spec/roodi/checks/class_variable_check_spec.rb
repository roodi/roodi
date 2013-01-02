require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Roodi::Checks::ClassVariableCheck do
  before(:each) do
    @roodi = Roodi::Core::Runner.new(Roodi::Checks::ClassVariableCheck.make)
  end
  
  it "should reject class variables" do
    content = <<-END
    @@foo
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should match(/dummy-file.rb:[1-2] - Don't use class variables. You might want to try a different design./)
  end
end
