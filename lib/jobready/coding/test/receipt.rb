# frozen_string_literal: true

require "bigdecimal"
require "csv"

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
          # using col_sep of ", " would be ideal here, but the ruby
          # CSV generator is a bit over-eager with its escaping, and
          # will add quotes around any string that contains _any_ of
          # the characters in col_sep, rather than checking for the
          # presence of the entirety of col_sep.

          # This would usually not be an issue, but in this case the
          # target of this is specified to not include those quotes,
          # so we're going to hack around it a bit.

          # Step 1: Generate the CSV, using "," as the column separator
          csv_string = CSV.generate(col_sep: ",") do |csv|
            basket.line_items.each do |line_item|
              csv << [
                line_item.quantity.to_i,
                line_item.description,
                "%.2f" % (line_item.price + taxes[line_item])
              ]
            end
          end

          # In this case, our CSV has only three fields, so each row
          # has at least two commas that need a space added after
          # them: one between the first and the second field, and one
          # between the second and third field.  The first and third
          # fields, both being numbers, will never have a comma as
          # part of their field data. The second field could have
          # commas galore, with or without subsequent spaces, but they
          # would be quoted. And we must not change them.

          # As an example:
          # 2,"something, with a comma",12.50
          # 1,something with no comma,12.50

          # Because there are only two commas that should have a space
          # added after, and they will always be the first and the
          # last comma on each line, we can do the following regexp
          # replacements without messing up anything in the quoted
          # middle field.

          # But a better idea would be to have a chat with whoever's
          # set this test and see if this is actually necessary, or if
          # their CSV reader at the other end will accept either
          # straight commas as column separators or quoted line item
          # descriptions.

          csv_string.gsub!(/^([^,]*),/, '\1, ')
          csv_string.gsub!(/,([^,]*)$/, ', \1')

          output.write(csv_string)
          output.write("\n")
          output.write("Sales Taxes: #{'%.2f' % tax_total}\n")
          output.write("Total: #{'%.2f' % total}\n")
        end
      end
    end
  end
end
