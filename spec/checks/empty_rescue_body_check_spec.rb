require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'roodi'
require 'checks/empty_rescue_body_check'

describe EmptyRescueBodyCheck do
  before(:each) do
    @roodi = Roodi.new(EmptyRescueBodyCheck.new)
  end
  
  it "should accept a rescue body with content and no parameter" do
    content = <<-END
    begin
      call_method
    rescue
      puts "Recover from the call"
    end
    END
    @roodi.check_content(content)
    @roodi.errors.should be_empty
  end

  it "should accept a rescue body with content and a parameter" do
    content = <<-END
    begin
      call_method
    rescue Exception => e
      puts "Recover from the call"
    end
    END
    @roodi.check_content(content)
    @roodi.errors.should be_empty
  end

  it "should reject an empty rescue block with no parameter" do
    content = <<-END
    begin
      call_method
    rescue
    end
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].should eql("dummy-file.rb:3 - Rescue block should not be empty.")
  end

  it "should reject an empty rescue block with a parameter" do
    content = <<-END
    begin
      call_method
    rescue Exception => e
    end
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].should eql("dummy-file.rb:3 - Rescue block should not be empty.")
  end
end
