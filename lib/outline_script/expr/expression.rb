# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An Expression that can be evaluated.
#

module OutlineScript
  module Expr
    class Expression
      
      # Create the expression from a list of tokens.
      def initialize tokens
        @tokens = tokens
        @symbols = []
        @left = nil
        @right = nil
        @op = nil
      end
      
      # Evaluate the expression and return the value.
      def evaluate
        identify_tokens
        
        @symbols.each do |sym|
          if sym.is_a? OutlineScript::Core::Op
            @op = sym
          elsif @left == nil
            @left = sym
          else
            @right = sym
          end
          
          perform_op if @left && @right
        end
        
        if @left.is_a? OutlineScript::Core::Literal 
          return @left.value
        elsif @left.is_a? OutlineScript::Core::ObjRef
          return resolve_ref @left
        else
          return @left
        end
      end
      
      # Perform the operation.
      def perform_op
        @op = OutlineScript::Core::Op.default_op unless @op
        l = evaluate_sym @left
        r = evaluate_sym @right
        @left = @op.perform l, r
        @right = nil
        @op = nil
      end
      
      # Evaluate the symbol and get a simple value.
      def evaluate_sym sym
        if sym.is_a? OutlineScript::Core::Literal
          return sym.value
        elsif sym.is_a? OutlineScript::Core::ObjRef
          return resolve_ref sym
        else
          return sym
        end
      end
      
      # resolve an object reference and get the value.
      def resolve_ref ref
        ob = ref.resolve
        return ob.value if ob
      end
      
      # Identify each token in the list.
      def identify_tokens
        @tokens.each do |o|
          @symbols << identify_token( o )
        end
        
        # @symbols.each do |o|
        #   puts o.class.name
        # end
      end
      
      # 
      # Identify the tokens and create appropriate symbols.
      # 
      def identify_token token
        if OutlineScript::Core::Op.is_op?( token )
          return OutlineScript::Core::Op.create_op( token )
        end
        
        return LInteger.new( token ) if LInteger.is_integer?( token )
        return LString.new( token ) if LString.is_string?( token )
        
        # last chance: an Object reference
        return OutlineScript::Core::ObjRef.new( token )
      end
      
    end
  end
end
