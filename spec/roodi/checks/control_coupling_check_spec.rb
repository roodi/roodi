require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Roodi::Checks::ControlCouplingCheck do
  before(:each) do
    @roodi = Roodi::Core::Runner.new(Roodi::Checks::ControlCouplingCheck.make)
  end
  
  it "should reject methods with if checks using a parameter" do
    content = <<-END
    def write(quoted, foo)
     if quoted
       write_quoted(@value)
     else
       puts @value
      end
    end
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should match(/dummy-file.rb:[2-3] - Method \"write\" uses the argument \"quoted\" for internal control./)
  end
end
