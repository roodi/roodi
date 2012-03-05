require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Roodi::Checks::CaseMissingElseCheck do
  before(:each) do
    @roodi = Roodi::Core::Runner.new(Roodi::Checks::CaseMissingElseCheck.make)
  end
  
  it "should accept case statements that do have an else" do
    content = <<-END
    case foo
      when "bar": "ok"
      else "good"
    end
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should be_empty
  end
  
  it "should reject case statements that do have an else" do
    content = <<-END
    case foo
      when "bar": "ok"
      when "bar": "bad"
    end
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should match(/dummy-file.rb:[1-2] - Case statement is missing an else clause./)
  end
end
