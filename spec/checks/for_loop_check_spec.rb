require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'roodi'
require 'checks/for_loop_check'

describe ForLoopCheck do
  before(:each) do
    @roodi = Roodi.new(ForLoopCheck.new)
  end
  
  it "should reject for loops" do
    content = <<-END
    for i in 1..2
    end
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].should eql("dummy-file.rb:1 - Don't use 'for' loops. Use Enumerable.each instead.")
  end
end
