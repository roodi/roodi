require 'java'

include_class 'org.jruby.ast.AliasNode'
include_class 'org.jruby.ast.AndNode'
include_class 'org.jruby.ast.ArgsCatNode'
include_class 'org.jruby.ast.ArgsNode'
include_class 'org.jruby.ast.ArgsPushNode'
include_class 'org.jruby.ast.ArrayNode'
include_class 'org.jruby.ast.AttrAssignNode'
include_class 'org.jruby.ast.BackRefNode'
include_class 'org.jruby.ast.BeginNode'
include_class 'org.jruby.ast.BignumNode'
include_class 'org.jruby.ast.BlockArgNode'
include_class 'org.jruby.ast.BlockNode'
include_class 'org.jruby.ast.BlockPassNode'
include_class 'org.jruby.ast.BreakNode'
include_class 'org.jruby.ast.CallNode'
include_class 'org.jruby.ast.CaseNode'
include_class 'org.jruby.ast.ClassNode'
include_class 'org.jruby.ast.ClassVarAsgnNode'
include_class 'org.jruby.ast.ClassVarDeclNode'
include_class 'org.jruby.ast.ClassVarNode'
include_class 'org.jruby.ast.Colon2Node'
include_class 'org.jruby.ast.Colon3Node'
include_class 'org.jruby.ast.ConstDeclNode'
include_class 'org.jruby.ast.ConstNode'
include_class 'org.jruby.ast.DAsgnNode'
include_class 'org.jruby.ast.DRegexpNode'
include_class 'org.jruby.ast.DStrNode'
include_class 'org.jruby.ast.DSymbolNode'
include_class 'org.jruby.ast.DVarNode'
include_class 'org.jruby.ast.DXStrNode'
include_class 'org.jruby.ast.DefinedNode'
include_class 'org.jruby.ast.DefnNode'
include_class 'org.jruby.ast.DefsNode'
include_class 'org.jruby.ast.DotNode'
include_class 'org.jruby.ast.EnsureNode'
include_class 'org.jruby.ast.EvStrNode'
include_class 'org.jruby.ast.FCallNode'
include_class 'org.jruby.ast.FalseNode'
include_class 'org.jruby.ast.FixnumNode'
include_class 'org.jruby.ast.FlipNode'
include_class 'org.jruby.ast.FloatNode'
include_class 'org.jruby.ast.ForNode'
include_class 'org.jruby.ast.GlobalAsgnNode'
include_class 'org.jruby.ast.GlobalVarNode'
include_class 'org.jruby.ast.HashNode'
include_class 'org.jruby.ast.IfNode'
include_class 'org.jruby.ast.InstAsgnNode'
include_class 'org.jruby.ast.InstVarNode'
include_class 'org.jruby.ast.IterNode'
include_class 'org.jruby.ast.LocalAsgnNode'
include_class 'org.jruby.ast.LocalVarNode'
include_class 'org.jruby.ast.Match2Node'
include_class 'org.jruby.ast.Match3Node'
include_class 'org.jruby.ast.MatchNode'
include_class 'org.jruby.ast.ModuleNode'
include_class 'org.jruby.ast.MultipleAsgnNode'
include_class 'org.jruby.ast.NewlineNode'
include_class 'org.jruby.ast.NextNode'
include_class 'org.jruby.ast.NilNode'
include_class 'org.jruby.ast.NotNode'
include_class 'org.jruby.ast.NthRefNode'
include_class 'org.jruby.ast.OpAsgnAndNode'
include_class 'org.jruby.ast.OpAsgnNode'
include_class 'org.jruby.ast.OpAsgnOrNode'
include_class 'org.jruby.ast.OpElementAsgnNode'
include_class 'org.jruby.ast.OrNode'
include_class 'org.jruby.ast.PostExeNode'
include_class 'org.jruby.ast.PreExeNode'
include_class 'org.jruby.ast.RedoNode'
include_class 'org.jruby.ast.RegexpNode'
include_class 'org.jruby.ast.RescueBodyNode'
include_class 'org.jruby.ast.RescueNode'
include_class 'org.jruby.ast.RetryNode'
include_class 'org.jruby.ast.ReturnNode'
include_class 'org.jruby.ast.RootNode'
include_class 'org.jruby.ast.SClassNode'
include_class 'org.jruby.ast.SValueNode'
include_class 'org.jruby.ast.SelfNode'
include_class 'org.jruby.ast.SplatNode'
include_class 'org.jruby.ast.StrNode'
include_class 'org.jruby.ast.SuperNode'
include_class 'org.jruby.ast.SymbolNode'
include_class 'org.jruby.ast.ToAryNode'
include_class 'org.jruby.ast.TrueNode'
include_class 'org.jruby.ast.UndefNode'
include_class 'org.jruby.ast.UntilNode'
include_class 'org.jruby.ast.VAliasNode'
include_class 'org.jruby.ast.VCallNode'
include_class 'org.jruby.ast.WhenNode'
include_class 'org.jruby.ast.WhileNode'
include_class 'org.jruby.ast.XStrNode'
include_class 'org.jruby.ast.YieldNode'
include_class 'org.jruby.ast.ZArrayNode'
include_class 'org.jruby.ast.ZSuperNode'
include_class 'org.jruby.evaluator.Instruction'
include_class 'org.jruby.ast.visitor.NodeVisitor'

module Roodi
  module Core
    class PrintingVisitor
      include NodeVisitor
  
    	def initialize
      	@depth = 0
    	end
	
    	def print_node(node)
    	  @depth.times { print '  ' }
    	  puts node
      end
	
    	def visitAliasNode(visited)
    	  print_node(visited)
    		nil
    	end

    	def visitAndNode(visited)
    		visited.getFirstNode.accept(self)
    		print_node(visited)
    		visited.getSecondNode.accept(self)
    		nil
    	end

    	def visitArgsNode(visited)
    	  print_node(visited)
    		visited.getOptArgs.accept(self) if visited.getOptArgs
        nil
    	end

    	def visitArgsCatNode(visited)
    	  print_node(visited)
    		visited.getFirstNode.accept(self) if visited.getFirstNode
    		visited.getSecondNode.accept(self) if visited.getSecondNode
        nil
    	end

      def visitArgsPushNode(visited)
        print_node(visited)
        visited.getFirstNode.accept(self) if visited.getFirstNode
        visited.getSecondNode.accept(self) if visited.getSecondNode
        nil
      end
    
      def visitAttrAssignNode(visited) 
        print_node(visited)
        visited.getArgsNode.accept(self) if visited.getArgsNode
        visited.getReceiverNode.accept(self) if visited.getReceiverNode
        nil
      end

      def visitArrayNode(visited) 
        print_node(visited)
        (0..(visited.size - 1)).each { |i| visited.get(i).accept(self) }
        nil
      end

    	def visitBackRefNode(visited)
    	  print_node(visited)
        nil
    	end

    	def visitBeginNode(visited) 
    	  print_node(visited)
    	  visited.getBodyNode.accept(self) if visited.getBodyNode
        nil
    	end

    	def visitBlockArgNode(visited) 
    	  print_node(visited)
    		nil
    	end

    	def visitBlockNode(visited) 
    	  print_node(visited)
    		(0..(visited.size - 1)).each { |i| visited.get(i).accept(self) }
    		nil
    	end

    	def visitBlockPassNode(visited) 
    	  print_node(visited)
    	  nil
    	end

    	def visitBreakNode(visited)
    	  print_node(visited)
    	  nil
    	end

    	def visitConstDeclNode(visited)
    	  print_node(visited)
    	  visited.getValueNode.accept(self)
    	  nil
    	end

    	def visitClassVarAsgnNode(visited)
    	  print_node(visited)
    	  visited.getValueNode.accept(self)
    	  nil
    	end

    	def visitClassVarDeclNode(visited) 
    		print_node(visited)
    	  nil
    	end

    	def visitClassVarNode(visited) 
    		print_node(visited)
    	  nil
    	end

    	def visitCallNode(visited) 
    		visited.getReceiverNode.accept(self)
    		visited.getArgsNode.accept(self) if visited.getArgsNode
    		visited.getIterNode.accept(self) if visited.getIterNode
    		print_node(visited)
     	  nil
    	end

    	def visitCaseNode(visited)
    	  print_node(visited)
    	  visited.getCaseNode.accept(self)
    	  visited.getFirstWhenNode.accept(self)
    		nil
    	end

    	def visitClassNode(visited) 
    	  print_node(visited)
    		visited.getSuperNode.accept(self) if visited.getSuperNode
    		visited.getBodyNode.accept(self)
    	  nil
    	end

    	def visitColon2Node(visited) 
    		visited.getLeftNode.accept(self) if visited.getLeftNode
    	  print_node(visited)
    	  nil
    	end

    	def visitColon3Node(visited) 
    	  print_node(visited)
    	  nil
    	end

    	def visitConstNode(visited) 
    	  print_node(visited)
    	  nil
    	end

    	def visitDAsgnNode(visited) 
    	  print_node(visited)
    		visited.getValueNode.accept(self)
    	  nil
    	end

    	def visitDRegxNode(visited) 
    	  print_node(visited)
    	  nil
    	end

    	def visitDStrNode(visited) 
    	  print_node(visited)
    	  nil
    	end

    	def visitDSymbolNode(visited) 
    	  print_node(visited)
    	  nil
    	end

    	def visitDVarNode(visited) 
    	  print_node(visited)
    	  nil
    	end

    	def visitDXStrNode(visited) 
    	  print_node(visited)
    	  nil
    	end

    	def visitDefinedNode(visited) 
    	  print_node(visited)
    	  nil
    	end

    	def visitDefnNode(visited) 
    	  print_node(visited)
    		visited.getBodyNode.accept(self) if visited.getBodyNode
    		nil
    	end

    	def visitDefsNode(visited) 
    	  print_node(visited)
    		visited.getReceiverNode.accept(self)
    		visited.getBodyNode.accept(self) if visited.getBodyNode
    		nil
    	end

    	def visitDotNode(visited) 
    	  print_node(visited)
    	  nil
    	end

    	def visitEnsureNode(visited) 
    	  print_node(visited)
    	  nil
    	end

    	def visitEvStrNode(visited) 
    	  print_node(visited)
    	  nil
    	end

    	def visitFCallNode(visited) 
    		print_node(visited)
    		if(visited.getArgsNode != nil) 
    			visited.getArgsNode.accept(self)
    		end
    		if(visited.getIterNode != nil) 
    			visited.getIterNode.accept(self)
    		end
    		 nil
    	end

    	def visitFalseNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitFlipNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitForNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitGlobalAsgnNode(visited) 
    		print_node(visited)
    		visited.getValueNode.accept(self)
    		 nil
    	end

    	def visitGlobalVarNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitHashNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitInstAsgnNode(visited) 
    		print_node(visited)
    		visited.getValueNode.accept(self)
    		 nil
    	end

    	def visitInstVarNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitIfNode(visited) 
    		print_node(visited)
    		visited.getCondition.accept(self)
    		visited.getThenBody.accept(self) if visited.getThenBody
    		visited.getElseBody.accept(self) if visited.getElseBody
    		nil
    	end

    	def visitIterNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitLocalAsgnNode(visited) 
    		print_node(visited)
    		visited.getValueNode.accept(self)
    		 nil
    	end

    	def visitLocalVarNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitMultipleAsgnNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitMatch2Node(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitMatch3Node(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitMatchNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitModuleNode(visited) 
    		print_node(visited)
    		visited.getBodyNode.accept(self)
    		 nil
    	end

    	def visitNewlineNode(visited) 
    		print_node(visited)
    		visited.getNextNode.accept(self)
    		 nil
    	end

    	def visitNextNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitNilNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitNotNode(visited) 
    		print_node(visited)
    		visited.getConditionNode.accept(self)
    		 nil
    	end

    	def visitNthRefNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitOpElementAsgnNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitOpAsgnNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitOpAsgnAndNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitOpAsgnOrNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitOrNode(visited) 
    		visited.getFirstNode.accept(self)
    		print_node(visited)
    		visited.getSecondNode.accept(self)
    		 nil
    	end

    	def visitPostExeNode(visited) 
    		print_node(visited)
    		 nil
    	end

        def visitPreExeNode(visited) 
            print_node(visited)
             nil
        end
    
    	def visitRedoNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitRescueBodyNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitRescueNode(visited) 
    		print_node(visited)
    		visited.getBodyNode.accept(self) if visited.getBodyNode
    		visited.getRescueNode.accept(self) if visited.getRescueNode
    		visited.getElseNode.accept(self) if visited.getElseNode
    		 nil
    	end

    	def visitRetryNode(visited) 
    		print_node(visited)
    		 nil
    	end
    
        def visitRootNode(visited) 
            print_node(visited)
            visited.getBodyNode.accept(self)
             nil
        end

    	def visitReturnNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitSClassNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitSelfNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitSplatNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitStrNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitSValueNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitSuperNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitToAryNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitTrueNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitUndefNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitUntilNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitVAliasNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitVCallNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitWhenNode(visited) 
    		print_node(visited)
    		visited.getExpressionNodes.accept(self) if visited.getExpressionNodes
    		visited.getBodyNode.accept(self) if visited.getBodyNode
    		visited.getNextCase.accept(self) if visited.getNextCase
  		  nil
    	end

    	def visitWhileNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitXStrNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitYieldNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitZArrayNode(visited) 
    		print_node(visited)
    		 nil
    	end

    	def visitZSuperNode(visited) 
    		print_node(visited)
    		nil
    	end

    	def visitBignumNode(visited) 
    		print_node(visited)
    		nil
    	end

    	def visitFixnumNode(visited) 
    		print_node(visited)
    		nil
    	end

    	def visitFloatNode(visited) 
    		print_node(visited)
    		nil
    	end

    	def visitRegexpNode(visited) 
    		print_node(visited)
    		nil
    	end

    	def visitSymbolNode(visited) 
    		print_node(visited)
    		nil
    	end
    end
  end
end
