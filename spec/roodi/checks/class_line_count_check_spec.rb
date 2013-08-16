require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Roodi::Checks::ClassLineCountCheck do
  before(:each) do
    @roodi = Roodi::Core::Runner.new(Roodi::Checks::ClassLineCountCheck.make({'line_count' => 1}))
  end

  it "should accept classes with less lines than the threshold" do
    content = <<-END
    class ZeroLineClass
    end
    END
    @roodi.check_content(content)
    @roodi.errors.should be_empty
  end

  it "should accept classes with the same number of lines as the threshold" do
    content = <<-END
    class OneLineClass
      @foo = 1
    end
    END
    @roodi.check_content(content)
    @roodi.errors.should be_empty
  end

  it "should reject classes with more lines than the threshold" do
    content = <<-END
    class TwoLineClass
      @foo = 1
      @bar = 2
    end
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("dummy-file.rb:1 - Class \"TwoLineClass\" has 2 lines.  It should have 1 or less.")
  end
end
