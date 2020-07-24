# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2020 Eric Crane.  All rights reserved.
#
# A literal decimal value.
#

module Gloo
  module Expr
    class LDecimal < Gloo::Core::Literal

      #
      # Is the given token a decimal?
      #
      def self.decimal?( token )
        return token.is_a? Numeric
      end

      # Set the value, converting to an integer.
      def set_value( value )
        @value = value.to_f
      end

      def to_s
        return self.value.to_s
      end

    end
  end
end
