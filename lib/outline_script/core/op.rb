# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An Operator; part of an expression.
#

module OutlineScript
  module Core
    class Op
                  
      # Is the token an operator?
      def self.is_op? token
        return [ "+", "-", "*", "/" ].include?( token.strip )
      end
      
      # Create the operator for the given token.
      def self.create_op token
        return OutlineScript::Expr::OpMinus.new if token == '-'
        return OutlineScript::Expr::OpMult.new if token == '*'
        return OutlineScript::Expr::OpDiv.new if token == '/'
        return OutlineScript::Expr::OpPlus.new if token == '+'
        
        return default_op
      end
      
      # Get the default operator (+).
      def self.default_op
        return OutlineScript::Expr::OpPlus.new
      end
      
    end
  end
end
