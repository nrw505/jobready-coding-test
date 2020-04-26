# frozen_string_literal: true

require "bigdecimal"

module Jobready
  module Coding
    module Test
      class Receipt
        def initialize(basket)
          @basket = basket
          @total = nil
          @tax_total = nil
          @taxes = {}
        end

        def basket
          @basket
        end

        def total
          @total
        end

        def tax_total
          @tax_total
        end

        def taxes
          @taxes
        end

        def calculate!(calculator)
          @tax_total = BigDecimal(0)
          @total = BigDecimal(0)

          basket.line_items.each do |line_item|
            @taxes[line_item] = calculator.calculate(line_item)
            @tax_total += @taxes[line_item] * line_item.quantity
            @total += line_item.price * line_item.quantity
          end
          @total += @tax_total
        end

        def write(output)
          # CSV.generate makes it annoying to match the expected
          # output.  So manually escape the field that might contain
          # field separators if necessary and just form up the CSV
          # with string concatenation, it's simpler than trying to
          # munge the output of CSV.generate

          csv_string = ""
          basket.line_items.each do |line_item|
            quoted_description = line_item.description
            if quoted_description.include? ", "
              quoted_description.gsub!('"', '""')
              quoted_description = '"' + quoted_description + '"'
            end
            csv_string += "#{line_item.quantity.to_i}, #{quoted_description}, #{'%.2f' % (line_item.price + taxes[line_item])}\n"
          end

          output.write(csv_string)
          output.write("\n")
          output.write("Sales Taxes: #{'%.2f' % tax_total}\n")
          output.write("Total: #{'%.2f' % total}\n")
        end
      end
    end
  end
end
