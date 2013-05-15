require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Roodi::Checks::EmptyRescueBodyCheck do
  before(:each) do
    @roodi = Roodi::Core::Runner.new(Roodi::Checks::EmptyRescueBodyCheck.make)
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

  it "should accept a rescue body with a return" do
    content = <<-END
    begin
      call_method
    rescue
      return true
    end
    END
    @roodi.check_content(content)
    @roodi.errors.should be_empty
  end

  it "should accept a method call that Ruby won't tell apart from a variable (a vcall)" do
    content = <<-END
    begin
      call_method
    rescue
      show_error
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

  it "should accept a rescue body with an assignment" do
    content = <<-END
    begin
      call_method
    rescue Exception => e
      my_var = 1
    end
    END
    @roodi.check_content(content)
    @roodi.errors.should be_empty
  end

  it "should accept a rescue body with an attribute assignment" do
    content = <<-END
    begin
      call_method
    rescue Exception => e
      self.var = 1
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
    errors[0].to_s.should match(/dummy-file.rb:[3-4] - Rescue block should not be empty./)
  end

  it "should accept a rescue block with an explicit nil" do
    content = <<-END
    call_method rescue nil
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should be_empty
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
    errors[0].to_s.should match(/dummy-file.rb:[3-4] - Rescue block should not be empty./)
  end

  it "should accept a rescue block that returns true" do
    content = <<-END
    begin
      call_method
    rescue Exception => e
      true
    end
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should be_empty
  end

  it "should accept a rescue block that returns false" do
    content = <<-END
    begin
      call_method
    rescue Exception => e
      false
    end
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should be_empty
  end

  it "should accept a rescue block that has only a next statement" do
    content = <<-END
    begin
      call_method
    rescue Exception => e
      next
    end
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should be_empty
  end

end
