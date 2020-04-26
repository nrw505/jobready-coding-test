# frozen_string_literal: true

require "bigdecimal"
require "csv"

module Jobready
  module Coding
    module Test
      class Basket
        def initialize(input = nil)
          @line_items = []
          unless input.nil?
            read(input)
          end
        end

        def line_items
          @line_items
        end

        def read(input)
          csv = CSV.new(input, col_sep: ", ", headers: true)
          csv.each do |row|
            line_item = LineItem.new(row["Quantity"], row["Product"], row["Price"])
            @line_items << line_item
          end
        end
      end
    end
  end
end
