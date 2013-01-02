require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Roodi::Checks::MethodLineCountCheck do
  before(:each) do
    @roodi = Roodi::Core::Runner.new(Roodi::Checks::MethodLineCountCheck.make({'line_count' => 1}))
  end
  
  it "should accept methods with less lines than the threshold" do
    content = <<-END
    def zero_line_method
    end
    END
    @roodi.check_content(content)
    @roodi.errors.should be_empty
  end

  it "should accept methods with the same number of lines as the threshold" do
    content = <<-END
    def one_line_method
      1
    end
    END
    @roodi.check_content(content)
    @roodi.errors.should be_empty
  end

  it "should reject methods with more lines than the threshold" do
    content = <<-END
    def two_line_method
      puts 1
      puts 2
    end
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("dummy-file.rb:1 - Method \"two_line_method\" has 2 lines.  It should have 1 or less.")
  end

  it "should count only lines from the method" do
    content = <<-END
    def first_method
      puts 1
    end

    def second_method
      puts 1
      puts 2
    end
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("dummy-file.rb:5 - Method \"second_method\" has 2 lines.  It should have 1 or less.")
  end
end
