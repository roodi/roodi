require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Roodi::Checks::ForLoopCheck do
  before(:each) do
    @roodi = Roodi::Core::ParseTreeRunner.new(Roodi::Checks::ForLoopCheck.new)
  end
  
  it "should reject for loops" do
    content = <<-END
    for i in 1..2
    end
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].should eql("dummy-file.rb - Don't use 'for' loops. Use Enumerable.each instead.")
  end
end
