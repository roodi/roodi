require 'roodi/checks/line_count_check'

module Roodi
  module Checks
    # Checks a module to make sure the number of lines it has is under the specified limit.
    # 
    # A module getting too large is a code smell that indicates it might be taking on too many 
    # responsibilities.  It should probably be refactored into multiple smaller modules. 
    class ModuleLineCountCheck < LineCountCheck

      DEFAULT_LINE_COUNT = 300
      
      def initialize
        super()
        self.line_count = DEFAULT_LINE_COUNT
      end

      def interesting_nodes
        [:module]
      end

      def message_prefix
        'Module'
      end

    end
  end
end
