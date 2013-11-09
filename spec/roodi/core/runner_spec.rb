require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Roodi::Core::Runner do
  subject { Roodi::Core::Runner.new }

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

    it "checks that one file" do
      subject.start(['lib/roodi.rb'])
      expect(subject.files_checked).to eq 1
    end
  end

  describe "running against a directory" do
    it "checks all files in that directory recursively" do
      subject.start(['.'])
      expect(subject.files_checked).to be > 1
    end
  end

  describe "running without specifying files or directory" do
    it "checks all files in that directory recursively" do
      subject.start([])
      expect(subject.files_checked).to be > 1
    end
  end

  describe "configuration" do
    context "given a custom config file" do
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

    it "uses the default config if none given" do
      subject.stub(:project_config) { nil }
      expect(subject.default_config).to eq subject.default_config
    end

    it "uses roodi.yml if it exists" do
      subject.stub(:project_config) { "roodi.yml" }
      expect(subject.default_config).to eq "roodi.yml"
    end
  end

end
