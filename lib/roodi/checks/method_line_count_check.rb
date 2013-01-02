require 'roodi/checks/line_count_check'

module Roodi
  module Checks
    # Checks a method to make sure the number of lines it has is under the specified limit.
    # 
    # A method getting too large is a code smell that indicates it might be doing more than one 
    # thing and becoming hard to test.  It should probably be refactored into multiple methods 
    # that each do a single thing well. 
    class MethodLineCountCheck < LineCountCheck

      DEFAULT_LINE_COUNT = 20
      
      def initialize
        super()
        self.line_count = DEFAULT_LINE_COUNT
      end

      def interesting_nodes
        [:defn]
      end

      def message_prefix
        'Method'
      end

    end
  end
end
