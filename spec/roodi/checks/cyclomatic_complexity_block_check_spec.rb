require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Roodi::Checks::CyclomaticComplexityBlockCheck do
  before(:each) do
    @roodi = Roodi::Core::Runner.new(Roodi::Checks::CyclomaticComplexityBlockCheck.make({'complexity' => 0}))
  end

  def verify_content_complexity(content, complexity)
    @roodi.check_content(content)
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should match(/dummy-file.rb:[2-4] - Block cyclomatic complexity is #{complexity}.  It should be 0 or less./)
  end
  
  it "should find a simple block" do
    content = <<-END
    def method_name
      it "should be a simple block" do
        call_foo
      end
    end
    END
    verify_content_complexity(content, 1)
  end

  it "should find a block with multiple paths" do
    content = <<-END
    def method_name
      it "should be a complex block" do
        call_foo if some_condition
      end
    end
    END
    verify_content_complexity(content, 2)
  end
  
  it "should evaluate real example 1 correctly" do
    content = <<-END
    def method_name
      UNIXMbox.lock(@filename) {|f|
          begin
            f.each do |line|
              if /\AFrom / === line
                w.close if w
                File.utime time, time, port.filename if time

                port = @real.new_port
                w = port.wopen
                time = fromline2time(line)
              else
                w.print line if w
              end
            end
          ensure
            if w and not w.closed?
              w.close
              File.utime time, time, port.filename if time
            end
          end
          f.truncate(0) unless @readonly
          @updated = Time.now
      }
    end
    END
    verify_content_complexity(content, 9)
  end
end
