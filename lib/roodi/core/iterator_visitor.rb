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

class IteratorVisitor
  include NodeVisitor
  
	def initialize(payload)
  	@payload = payload
	end
	
	def visitAliasNode(visited) 
		visited.accept(@payload)
		nil
	end

	def visitAndNode(visited) 
		visited.getFirstNode().accept(self)
		visited.accept(@payload)
		visited.getSecondNode().accept(self)
		nil
	end

	def visitArgsNode(visited) 
		visited.accept(@payload)
		if (visited.getOptArgs() != nil) 
			visited.getOptArgs().accept(self)
		end
		 nil
	end

	def visitArgsCatNode(visited) 
		visited.accept(@payload)
		if (visited.getFirstNode() != nil) 
			visited.getFirstNode().accept(self)
		end
		if (visited.getSecondNode() != nil) 
			visited.getSecondNode().accept(self)
		end
		 nil
	end

    def visitArgsPushNode(visited) 
        visited.accept(@payload)
        if (visited.getFirstNode() != nil) 
            visited.getFirstNode().accept(self)
        end
        if (visited.getSecondNode() != nil) 
            visited.getSecondNode().accept(self)
        end
         nil
    end
    
    def visitAttrAssignNode(visited) 
        visited.accept(@payload)
        if(visited.getArgsNode() != nil) 
        	visited.getArgsNode().accept(self)
        end
        if(visited.getReceiverNode() != nil) 
        	visited.getReceiverNode().accept(self)
        end
         nil
    end

    def visitArrayNode(visited) 
		visited.accept(@payload)
		(0..(visited.size - 1)).each do |i|
      visited.get(i).accept(self)
	  end
	 nil
	end

	def visitBackRefNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitBeginNode(visited) 
		visited.accept(@payload)
	  visited.getBodyNode.accept(self) if visited.getBodyNode
		 nil
	end

	def visitBlockArgNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitBlockNode(visited) 
		visited.accept(@payload)
		(0..(visited.size - 1)).each do |i|
      visited.get(i).accept(self)
	  end
		 nil
	end

	def visitBlockPassNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitBreakNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitConstDeclNode(visited) 
		visited.accept(@payload)
		visited.getValueNode().accept(self)
		 nil
	end

	def visitClassVarAsgnNode(visited) 
		visited.accept(@payload)
		visited.getValueNode().accept(self)
		 nil
	end

	def visitClassVarDeclNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitClassVarNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitCallNode(visited) 
		visited.getReceiverNode().accept(self)
		if(visited.getArgsNode() != nil) 
			visited.getArgsNode().accept(self)
		end
		if(visited.getIterNode() != nil) 
			visited.getIterNode().accept(self)
		end
		visited.accept(@payload)
		 nil
	end

	def visitCaseNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitClassNode(visited) 
		visited.accept(@payload)
		if (visited.getSuperNode() != nil) 
			visited.getSuperNode().accept(self)
		end
		visited.getBodyNode().accept(self)
		 nil
	end

	def visitColon2Node(visited) 
		if (visited.getLeftNode() != nil) 
			visited.getLeftNode().accept(self)
		end
		visited.accept(@payload)
		 nil
	end

	def visitColon3Node(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitConstNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitDAsgnNode(visited) 
		visited.accept(@payload)
		visited.getValueNode().accept(self)
		 nil
	end

	def visitDRegxNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitDStrNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitDSymbolNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitDVarNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitDXStrNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitDefinedNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitDefnNode(visited) 
		visited.accept(@payload)
		visited.getBodyNode().accept(self) if visited.getBodyNode
		nil
	end

	def visitDefsNode(visited) 
		visited.accept(@payload)
		visited.getReceiverNode().accept(self)
		visited.getBodyNode().accept(self) if visited.getBodyNode
		nil
	end

	def visitDotNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitEnsureNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitEvStrNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitFCallNode(visited) 
		visited.accept(@payload)
		if(visited.getArgsNode() != nil) 
			visited.getArgsNode().accept(self)
		end
		if(visited.getIterNode() != nil) 
			visited.getIterNode().accept(self)
		end
		 nil
	end

	def visitFalseNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitFlipNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitForNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitGlobalAsgnNode(visited) 
		visited.accept(@payload)
		visited.getValueNode().accept(self)
		 nil
	end

	def visitGlobalVarNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitHashNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitInstAsgnNode(visited) 
		visited.accept(@payload)
		visited.getValueNode().accept(self)
		 nil
	end

	def visitInstVarNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitIfNode(visited) 
		visited.accept(@payload)
		visited.getCondition().accept(self)
		visited.getThenBody().accept(self) if visited.getThenBody
		visited.getElseBody().accept(self) if visited.getElseBody
		nil
	end

	def visitIterNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitLocalAsgnNode(visited) 
		visited.accept(@payload)
		visited.getValueNode().accept(self)
		 nil
	end

	def visitLocalVarNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitMultipleAsgnNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitMatch2Node(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitMatch3Node(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitMatchNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitModuleNode(visited) 
		visited.accept(@payload)
		visited.getBodyNode().accept(self)
		 nil
	end

	def visitNewlineNode(visited) 
		visited.accept(@payload)
		visited.getNextNode().accept(self)
		 nil
	end

	def visitNextNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitNilNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitNotNode(visited) 
		visited.accept(@payload)
		visited.getConditionNode().accept(self)
		 nil
	end

	def visitNthRefNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitOpElementAsgnNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitOpAsgnNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitOpAsgnAndNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitOpAsgnOrNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitOrNode(visited) 
		visited.getFirstNode().accept(self)
		visited.accept(@payload)
		visited.getSecondNode().accept(self)
		 nil
	end

	def visitPostExeNode(visited) 
		visited.accept(@payload)
		 nil
	end

    def visitPreExeNode(visited) 
        visited.accept(@payload)
         nil
    end
    
	def visitRedoNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitRescueBodyNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitRescueNode(visited) 
		visited.accept(@payload)
		visited.getBodyNode.accept(self) if visited.getBodyNode
		visited.getRescueNode.accept(self) if visited.getRescueNode
		visited.getElseNode.accept(self) if visited.getElseNode
		 nil
	end

	def visitRetryNode(visited) 
		visited.accept(@payload)
		 nil
	end
    
    def visitRootNode(visited) 
        visited.accept(@payload)
        visited.getBodyNode().accept(self)
         nil
    end

	def visitReturnNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitSClassNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitSelfNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitSplatNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitStrNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitSValueNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitSuperNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitToAryNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitTrueNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitUndefNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitUntilNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitVAliasNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitVCallNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitWhenNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitWhileNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitXStrNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitYieldNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitZArrayNode(visited) 
		visited.accept(@payload)
		 nil
	end

	def visitZSuperNode(visited) 
		visited.accept(@payload)
		nil
	end

	def visitBignumNode(visited) 
		visited.accept(@payload)
		nil
	end

	def visitFixnumNode(visited) 
		visited.accept(@payload)
		nil
	end

	def visitFloatNode(visited) 
		visited.accept(@payload)
		nil
	end

	def visitRegexpNode(visited) 
		visited.accept(@payload)
		nil
	end

	def visitSymbolNode(visited) 
		visited.accept(@payload)
		nil
	end
end
