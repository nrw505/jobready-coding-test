# frozen_string_literal: true

require "bigdecimal"

module Jobready
  module Coding
    module Test
      class LineItem
        def initialize(quantity, description, price)
          @quantity = BigDecimal(quantity)
          @description = description
          @price = BigDecimal(price)
        end

        def quantity
          @quantity
        end

        def description
          @description
        end

        def price
          @price
        end

        def is_sales_tax_exempt?
          Classifier.is_sales_tax_exempt?(description)
        end

        def is_imported?
          Classifier.is_imported?(description)
        end
      end
    end
  end
end
