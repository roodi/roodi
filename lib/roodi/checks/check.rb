module Roodi
  module Checks
    class Check
      def initialize
        @errors = []
      end
  
      def position(node)
        node.filename
      end
  
      def add_error(error)
        @errors << error
      end
  
      def errors
        @errors
      end
    end
  end
end
