require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Roodi::Checks::CoreMethodOverrideCheck do
  before(:each) do
    @roodi = Roodi::Core::Runner.new(Roodi::Checks::CoreMethodOverrideCheck.new)
  end

  it "should accept a class with a method" do
    content = <<-END
    class WellBehavedClass
      def well_behaved_method
      end
    end
    END
    @roodi.check_content(content)
    @roodi.errors.should be_empty
  end

  it "should reject a class which overrides the class method" do
    content = <<-END
    class BadClass
      def class
      end
    end
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("dummy-file.rb:2 - Class overrides method 'class'.")
  end
end