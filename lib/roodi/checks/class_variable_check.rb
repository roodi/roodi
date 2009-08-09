require 'roodi/checks/check'

module Roodi
  module Checks
    # Checks to make sure class variables are not being used..
    # 
    # Class variables in Ruby have a complicated inheritance policy, and their use 
    # can lead to mistakes.  Often an alternate design can be used to solve the 
    # problem instead.
    #
    # This check is looking for a code smell rather than a definite error.  If you're 
    # sure that you're doing the right thing, try turning this check off in your 
    # config file.
    class ClassVariableCheck < Check
      def interesting_nodes
        [:cvar]
      end

      def evaluate_start(node)
        add_error "Don't use class variables. You might want to try a different design."
      end
    end
  end
end
