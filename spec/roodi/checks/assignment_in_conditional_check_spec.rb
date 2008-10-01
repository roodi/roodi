require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Roodi::Checks::AssignmentInConditionalCheck do
  before(:each) do
    @roodi = Roodi::Core::ParseTreeRunner.new(Roodi::Checks::AssignmentInConditionalCheck.new)
  end
  
  it "should accept an assignment before an if clause" do
    content = <<-END
    count = count + 1 if some_condition
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should be_empty
  end

  it "should reject an assignment inside an if clause" do
    content = <<-END
    call_foo if bar = bam
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("dummy-file.rb:1 - Found = in conditional.  It should probably be an ==")
  end

  it "should reject an assignment inside an unless clause" do
    content = <<-END
    call_foo unless bar = bam
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("dummy-file.rb:1 - Found = in conditional.  It should probably be an ==")
  end

  it "should reject an assignment inside a while clause" do
    content = <<-END
    call_foo while bar = bam
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("dummy-file.rb:1 - Found = in conditional.  It should probably be an ==")
  end

  it "should reject an assignment inside an unless clause" do
    content = <<-END
    call_foo while bar = bam
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("dummy-file.rb:1 - Found = in conditional.  It should probably be an ==")
  end

  it "should reject an assignment inside a a ternary operator check clause" do
    content = <<-END
    call_foo (bar = bam) ? baz : bad
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("dummy-file.rb:1 - Found = in conditional.  It should probably be an ==")
  end
end
