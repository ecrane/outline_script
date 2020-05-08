# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Subtraction operator.
#

module Gloo
  module Expr
    class OpMinus < Gloo::Core::Op

      # Perform the operation and return the result.
      def perform( left, right )
        return left - right.to_i if left.is_a? Integer
      end

    end
  end
end
