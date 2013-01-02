require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Roodi::Checks::ModuleNameCheck do
  before(:each) do
    @roodi = Roodi::Core::Runner.new(Roodi::Checks::ModuleNameCheck.make)
  end
  
  it "should accept camel case module names starting in capitals" do
    content = <<-END
    module GoodModuleName 
    end
    END
    @roodi.check_content(content)
    @roodi.errors.should be_empty
  end

  it "should reject module names with underscores" do
    content = <<-END
    module Bad_ModuleName 
    end
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("dummy-file.rb:1 - Module name \"Bad_ModuleName\" should match pattern /^[A-Z][a-zA-Z0-9]*$/")
  end
end
