$: << File.join(File.dirname(__FILE__), '..', 'lib')
require 'checks/class_name_check'

describe ClassNameCheck do
  it "should accept camel case class names" do
    position = mock("position")
    position.stub!(:getFile).and_return("dummy_class_name_check.rb")
    position.stub!(:getStartLine).and_return(0)
    c_path = mock("c_path")
    c_path.stub!(:getName).and_return("GoodClassName")
    node = mock("class_node")
    node.stub!(:getCPath).and_return(c_path)
    node.stub!(:getPosition).and_return(position)
    
    check = ClassNameCheck.new
    check.evaluate(node)
  end
end
