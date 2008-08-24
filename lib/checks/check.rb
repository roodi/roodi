class Check
  def initialize
    @errors = []
  end
  
  def position(node)
    position = node.getPosition
    "#{position.getFile}:#{position.getStartLine + 1}"
  end
  
  def add_error(error)
    @errors << error
  end
  
  def errors
    @errors
  end
end