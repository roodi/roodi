require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Roodi::Checks::AbcMetricMethodCheck do
  before(:each) do
    @roodi = Roodi::Core::Runner.new(Roodi::Checks::AbcMetricMethodCheck.make({'score' => 0}))
  end

  def verify_content_score(content, a, b, c)
    score = Math.sqrt(a*a + b*b + c*c)
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("dummy-file.rb:1 - Method name \"method_name\" has an ABC metric score of <#{a},#{b},#{c}> = #{score}.  It should be 0 or less.")
  end
  
  # 1. Add one to the assignment count for each occurrence of an assignment 
  #  operator, excluding constant declarations: 
  #  
  #  =  *=  /=  %=  +=  <<=  >>=  &=  |=  ^=
  describe "when processing assignments" do
    ['=', '*=', '/=', '%=', '+=', '<<=', '>>=', '&=', '|=', '^='].each do |each|
      it "should find #{each}" do
        content = <<-END
        def method_name
          foo #{each} 1
        end
        END
        verify_content_score(content, 1, 0, 0)
      end
    end
  end
  
  # 3. Add one to the branch count for each function call or class method 
  #  call. 
  #  
  # 4. Add one to the branch count for each occurrence of the new operator. 
  describe "when processing branches" do
    it "should find a virtual method call" do
      content = <<-END
      def method_name
        call_foo
      end
      END
      verify_content_score(content, 0, 1, 0)
    end

    it "should find an explicit method call" do
      content = <<-END
      def method_name
        @object.call_foo
      end
      END
      verify_content_score(content, 0, 1, 0)
    end

    it "should exclude a condition" do
      content = <<-END
      def method_name
        @object.call_foo < 10
      end
      END
      verify_content_score(content, 0, 1, 1)
    end
  end
  
  # 5. Add one to the condition count for each use of a conditional operator: 
  #  
  #   ==  !=  <=  >=  <  > 
  #  
  # 6. Add one to the condition count for each use of the following 
  #  keywords: 
  #  
  #   else  case  default  try  catch  ? 
  #  
  # 7. Add one to the condition count for each unary conditional 
  #  expression. 
  describe "when processing conditions" do
    ['==', '!=', '<=', '>=', '<', '>'].each do |each|
      it "should find #{each}" do
        content = <<-END
        def method_name
          2 #{each} 1
        end
        END
        verify_content_score(content, 0, 0, 1)
      end
    end 
  end
end
