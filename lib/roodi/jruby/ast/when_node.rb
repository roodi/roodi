module Java
  module OrgJrubyAst
    class WhenNode
      def children
        children = []
    		children << getExpressionNodes if getExpressionNodes
    		children << getBodyNode if getBodyNode
    		children << getNextCase if getNextCase
    		children
      end
    end
  end
end
