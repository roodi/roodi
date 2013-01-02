require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Roodi::Checks::ModuleLineCountCheck do
  before(:each) do
    @roodi = Roodi::Core::Runner.new(Roodi::Checks::ModuleLineCountCheck.make({'line_count' => 1}))
  end
  
  it "should accept modules with less lines than the threshold" do
    content = <<-END
    module ZeroLineModule
    end
    END
    @roodi.check_content(content)
    @roodi.errors.should be_empty
  end

  it "should accept modules with the same number of lines as the threshold" do
    content = <<-END
    module OneLineModule
      @foo = 1
    end
    END
    @roodi.check_content(content)
    @roodi.errors.should be_empty
  end

  it "should reject modules with more lines than the threshold" do
    content = <<-END
    module TwoLineModule
      @foo = 1
      @bar = 2
    end
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("dummy-file.rb:1 - Module \"TwoLineModule\" has 2 lines.  It should have 1 or less.")
  end
end
