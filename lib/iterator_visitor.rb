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

# This is a Ruby port of a visitor in the JRuby code, but it seems to barf on some Ruby
# code.  The RecursiveVisitor is being used instead for now, but it may not parse everything
# in the right order.  I might need to come back to this instead eventually.
class IteratorVisitor
  include NodeVisitor
  
	def initialize(payload)
  	@payload = payload
	end

	def visitAliasNode(iVisited) 
		iVisited.accept(@payload)
		nil
	end

	def visitAndNode(iVisited) 
		iVisited.getFirstNode().accept(self)
		iVisited.accept(@payload)
		iVisited.getSecondNode().accept(self)
		nil
	end

	def visitArgsNode( iVisited) 
		iVisited.accept(@payload)
		if (iVisited.getOptArgs() != nil) 
			iVisited.getOptArgs().accept(self)
		end
		 nil
	end

	def visitArgsCatNode( iVisited) 
		iVisited.accept(@payload)
		if (iVisited.getFirstNode() != nil) 
			iVisited.getFirstNode().accept(self)
		end
		if (iVisited.getSecondNode() != nil) 
			iVisited.getSecondNode().accept(self)
		end
		 nil
	end

    def visitArgsPushNode( iVisited) 
        iVisited.accept(@payload)
        if (iVisited.getFirstNode() != nil) 
            iVisited.getFirstNode().accept(self)
        end
        if (iVisited.getSecondNode() != nil) 
            iVisited.getSecondNode().accept(self)
        end
         nil
    end
    
    def visitAttrAssignNode( iVisited) 
        iVisited.accept(@payload)
        if(iVisited.getArgsNode() != nil) 
        	iVisited.getArgsNode().accept(self)
        end
        if(iVisited.getReceiverNode() != nil) 
        	iVisited.getReceiverNode().accept(self)
        end
         nil
    end

    def visitArrayNode( iVisited) 
		iVisited.accept(@payload)
		(0..(iVisited.size - 1)).each do |i|
      iVisited.get(i).accept(self)
	  end
	 nil
	end

	def visitBackRefNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitBeginNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitBlockArgNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitBlockNode( iVisited) 
		iVisited.accept(@payload)
		(0..(iVisited.size - 1)).each do |i|
      iVisited.get(i).accept(self)
	  end
		 nil
	end

	def visitBlockPassNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitBreakNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitConstDeclNode( iVisited) 
		iVisited.accept(@payload)
		iVisited.getValueNode().accept(self)
		 nil
	end

	def visitClassVarAsgnNode( iVisited) 
		iVisited.accept(@payload)
		iVisited.getValueNode().accept(self)
		 nil
	end

	def visitClassVarDeclNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitClassVarNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitCallNode( iVisited) 
		iVisited.getReceiverNode().accept(self)
		if(iVisited.getArgsNode() != nil) 
			iVisited.getArgsNode().accept(self)
		end
		if(iVisited.getIterNode() != nil) 
			iVisited.getIterNode().accept(self)
		end
		iVisited.accept(@payload)
		 nil
	end

	def visitCaseNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitClassNode( iVisited) 
		iVisited.accept(@payload)
		if (iVisited.getSuperNode() != nil) 
			iVisited.getSuperNode().accept(self)
		end
		iVisited.getBodyNode().accept(self)
		 nil
	end

	def visitColon2Node( iVisited) 
		if (iVisited.getLeftNode() != nil) 
			iVisited.getLeftNode().accept(self)
		end
		iVisited.accept(@payload)
		 nil
	end

	def visitColon3Node( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitConstNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitDAsgnNode( iVisited) 
		iVisited.accept(@payload)
		iVisited.getValueNode().accept(self)
		 nil
	end

	def visitDRegxNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitDStrNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitDSymbolNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitDVarNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitDXStrNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitDefinedNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitDefnNode( iVisited) 
		iVisited.accept(@payload)
		iVisited.getBodyNode().accept(self)
		 nil
	end

	def visitDefsNode( iVisited) 
		iVisited.accept(@payload)
		iVisited.getReceiverNode().accept(self)
		iVisited.getBodyNode().accept(self)
		 nil
	end

	def visitDotNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitEnsureNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitEvStrNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitFCallNode( iVisited) 
		iVisited.accept(@payload)
		if(iVisited.getArgsNode() != nil) 
			iVisited.getArgsNode().accept(self)
		end
		if(iVisited.getIterNode() != nil) 
			iVisited.getIterNode().accept(self)
		end
		 nil
	end

	def visitFalseNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitFlipNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitForNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitGlobalAsgnNode( iVisited) 
		iVisited.accept(@payload)
		iVisited.getValueNode().accept(self)
		 nil
	end

	def visitGlobalVarNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitHashNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitInstAsgnNode( iVisited) 
		iVisited.accept(@payload)
		iVisited.getValueNode().accept(self)
		 nil
	end

	def visitInstVarNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitIfNode( iVisited) 
		iVisited.accept(@payload)
		iVisited.getCondition().accept(self)
		iVisited.getThenBody().accept(self)
		if (iVisited.getElseBody() != nil) 
			iVisited.getElseBody().accept(self)
		end
		 nil
	end

	def visitIterNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitLocalAsgnNode( iVisited) 
		iVisited.accept(@payload)
		iVisited.getValueNode().accept(self)
		 nil
	end

	def visitLocalVarNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitMultipleAsgnNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitMatch2Node( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitMatch3Node( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitMatchNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitModuleNode( iVisited) 
		iVisited.accept(@payload)
		iVisited.getBodyNode().accept(self)
		 nil
	end

	def visitNewlineNode( iVisited) 
		iVisited.accept(@payload)
		iVisited.getNextNode().accept(self)
		 nil
	end

	def visitNextNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitNilNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitNotNode( iVisited) 
		iVisited.accept(@payload)
		iVisited.getConditionNode().accept(self)
		 nil
	end

	def visitNthRefNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitOpElementAsgnNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitOpAsgnNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitOpAsgnAndNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitOpAsgnOrNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitOrNode( iVisited) 
		iVisited.getFirstNode().accept(self)
		iVisited.accept(@payload)
		iVisited.getSecondNode().accept(self)
		 nil
	end

	def visitPostExeNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

    def visitPreExeNode( iVisited) 
        iVisited.accept(@payload)
         nil
    end
    
	def visitRedoNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitRescueBodyNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitRescueNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitRetryNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end
    
    def visitRootNode( iVisited) 
        iVisited.accept(@payload)
        iVisited.getBodyNode().accept(self)
         nil
    end

	def visitReturnNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitSClassNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitSelfNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitSplatNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitStrNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitSValueNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitSuperNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitToAryNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitTrueNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitUndefNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitUntilNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitVAliasNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitVCallNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitWhenNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitWhileNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitXStrNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitYieldNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitZArrayNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitZSuperNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitBignumNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitFixnumNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitFloatNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitRegexpNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end

	def visitSymbolNode( iVisited) 
		iVisited.accept(@payload)
		 nil
	end
end
