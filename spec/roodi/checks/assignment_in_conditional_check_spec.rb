require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Roodi::Checks::AssignmentInConditionalCheck do
  before(:each) do
    @roodi = Roodi::Core::Runner.new(Roodi::Checks::AssignmentInConditionalCheck.make)
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
    content = 'call_foo (bar = bam) ? baz : bad'
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("dummy-file.rb:1 - Found = in conditional.  It should probably be an ==")
  end

  it "should reject an assignment after an 'and'" do
    content = <<-END
      call_foo if bar and bam = baz
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("dummy-file.rb:1 - Found = in conditional.  It should probably be an ==")
  end


  it "should reject an assignment after an 'or'" do
    content = <<-END
      call_foo if bar or bam = baz
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("dummy-file.rb:1 - Found = in conditional.  It should probably be an ==")
  end

  it "should reject an assignment after an '&&'" do
    content = <<-END
      call_foo if bar && bam = baz
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("dummy-file.rb:1 - Found = in conditional.  It should probably be an ==")
  end

  it "should reject an assignment after an '||'" do
    content = <<-END
      call_foo if bar || bam = baz
    END
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("dummy-file.rb:1 - Found = in conditional.  It should probably be an ==")
  end
end
