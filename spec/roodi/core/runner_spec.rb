require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Roodi::Core::Runner do
  subject { Roodi::Core::Runner.new }

  describe "given a custom config file" do
    before do
      subject.config= File.expand_path(File.dirname(__FILE__) + '/../roodi.yml')
    end

    it "uses check from it" do
      content = <<-RUBY
        class TestClass

          def METHOD

          end
        end
      RUBY
      subject.check_content(content)
      subject.errors.should be_empty
    end
  end

  describe "running against a file" do
    it "adds an error if file is not valid ruby" do
      content = <<-END
        <html>
        </html>
      END
      subject.check_content(content)
      expect(subject.errors).to_not be_empty
      expect(subject.errors[0]).to eq "dummy-file.rb looks like it's not a valid Ruby file."
    end
  end

end
