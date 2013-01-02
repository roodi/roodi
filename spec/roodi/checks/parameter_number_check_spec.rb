require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Roodi::Checks::ParameterNumberCheck do
  before(:each) do
    @roodi = Roodi::Core::Runner.new(Roodi::Checks::ParameterNumberCheck.make({'parameter_count' => 1}))
  end
  
  it "should accept methods with less lines than the threshold" do
    content = <<-END
    def zero_parameter_method
    end
    END
    @roodi.check_content(content)
    @roodi.errors.should be_empty
  end

  it "should accept methods with the same number of parameters as the threshold" do
    content = <<-END
    def one_parameter_method(first_parameter)
    end
    END
    @roodi.check_content(content)
    @roodi.errors.should be_empty
  end

  it "should reject methods with more parameters than the threshold" do
    content = <<-END
    def two_parameter_method(first_parameter, second_parameter)
    end
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("dummy-file.rb:1 - Method name \"two_parameter_method\" has 2 parameters.  It should have 1 or less.")
  end

  it "should cope with default values on parameters" do
    content = <<-END
    def two_parameter_method(first_parameter = 1, second_parameter = 2)
    end
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("dummy-file.rb:1 - Method name \"two_parameter_method\" has 2 parameters.  It should have 1 or less.")
  end
end
