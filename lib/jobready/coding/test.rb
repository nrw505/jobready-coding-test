# frozen_string_literal: true

require "jobready/coding/test/version"
require "jobready/coding/test/classifier"
require "jobready/coding/test/line_item"
require "jobready/coding/test/tax_calculator"
require "jobready/coding/test/basket"
require "jobready/coding/test/receipt"

module Jobready
  module Coding
    module Test
      class Error < StandardError; end
    end
  end
end
