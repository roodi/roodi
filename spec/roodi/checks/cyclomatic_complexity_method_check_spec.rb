require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Roodi::Checks::CyclomaticComplexityMethodCheck do
  before(:each) do
    @roodi = Roodi::Core::Runner.new(Roodi::Checks::CyclomaticComplexityMethodCheck.make({'complexity' => 0}))
  end

  def verify_content_complexity(content, complexity)
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("dummy-file.rb:1 - Method name \"method_name\" cyclomatic complexity is #{complexity}.  It should be 0 or less.")
  end
  
  it "should find an if block" do
    content = <<-END
    def method_name
      call_foo if some_condition
    end
    END
    verify_content_complexity(content, 2)
  end

  it "should find an unless block" do
    content = <<-END
    def method_name
      call_foo unless some_condition
    end
    END
    verify_content_complexity(content, 2)
  end

  it "should find an elsif block" do
    content = <<-END
    def method_name
      if first_condition then
        call_foo
      elsif second_condition then
        call_bar
      else
        call_bam
      end
    end
    END
    verify_content_complexity(content, 3)
  end

  it "should find a ternary operator" do
    content = <<-END
    def method_name
      value = some_condition ? 1 : 2
    end
    END
    verify_content_complexity(content, 2)
  end

  it "should find a while loop" do
    content = <<-END
    def method_name
      while some_condition do
        call_foo
      end
    end
    END
    verify_content_complexity(content, 2)
  end

  it "should find an until loop" do
    content = <<-END
    def method_name
      until some_condition do
        call_foo
      end
    end
    END
    verify_content_complexity(content, 2)
  end

  it "should find a for loop" do
    content = <<-END
    def method_name
      for i in 1..2 do
        call_method
      end
    end
    END
    verify_content_complexity(content, 2)
  end

  it "should find a rescue block" do
    content = <<-END
    def method_name
      begin
        call_foo
      rescue Exception
        call_bar
      end
    end
    END
    verify_content_complexity(content, 2)
  end

  it "should find a case and when block" do
    content = <<-END
    def method_name
      case value
      when 1
        call_foo
      when 2
        call_bar
      end
    end
    END
    verify_content_complexity(content, 4)
  end

  it "should find the && symbol" do
    content = <<-END
    def method_name
      call_foo && call_bar
    end
    END
    verify_content_complexity(content, 2)
  end

  it "should find the and symbol" do
    content = <<-END
    def method_name
      call_foo and call_bar
    end
    END
    verify_content_complexity(content, 2)
  end

  it "should find the || symbol" do
    content = <<-END
    def method_name
      call_foo || call_bar
    end
    END
    verify_content_complexity(content, 2)
  end

  it "should find the or symbol" do
    content = <<-END
    def method_name
      call_foo or call_bar
    end
    END
    verify_content_complexity(content, 2)
  end

  it "should deal with nested if blocks containing && and ||" do
    content = <<-END
    def method_name
      if first_condition then
        call_foo if second_condition && third_condition
        call_bar if fourth_condition || fifth_condition
      end
    end
    END
    verify_content_complexity(content, 6)
  end

  it "should count stupid nested if and else blocks" do
    content = <<-END
    def method_name
      if first_condition then
        call_foo
      else
        if second_condition then
          call_bar
        else
          call_bam if third_condition
        end
        call_baz if fourth_condition
      end
    end
    END
    verify_content_complexity(content, 5)
  end

  it "should count only a single method" do
    content = <<-END
    def method_name_1
      call_foo if some_condition
    end
    def method_name_2
      call_foo if some_condition
    end
    END
    
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("dummy-file.rb:1 - Method name \"method_name_1\" cyclomatic complexity is 2.  It should be 0 or less.")
    errors[1].to_s.should eql("dummy-file.rb:4 - Method name \"method_name_2\" cyclomatic complexity is 2.  It should be 0 or less.")
  end

end
