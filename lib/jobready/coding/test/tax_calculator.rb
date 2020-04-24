# frozen_string_literal: true

require "bigdecimal"

module Jobready
  module Coding
    module Test
      class TaxCalculator
        def initialize(sales_rate: "0.10", import_rate: "0.05", rounding: "0.05")
          @sales_rate = BigDecimal(sales_rate)
          @import_rate = BigDecimal(import_rate)
          @rounding = BigDecimal(rounding)
        end

        def sales_rate
          @sales_rate
        end

        def import_rate
          @import_rate
        end

        def rounding
          @rounding
        end

        def calculate(line_item)
          tax = 0
          unless line_item.is_sales_tax_exempt?
            sales_tax = BigDecimal(line_item.price) * sales_rate
            tax += round_tax(sales_tax)
          end
          if line_item.is_imported?
            import_tax = BigDecimal(line_item.price) * import_rate
            tax += round_tax(import_tax)
          end
          tax
        end

        private
        def round_tax(tax_amount)
          quotient, modulus = tax_amount.divmod(rounding)
          if modulus == 0
            # We're exact, no rounding required.
            return tax_amount
          end
          (quotient + 1) * rounding # We always round up
        end
      end
    end
  end
end
