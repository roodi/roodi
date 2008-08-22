class Check
  def position(node)
    position = node.getPosition
    "#{position.getFile}:#{position.getStartLine + 1}"
  end
end