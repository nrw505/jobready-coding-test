# frozen_string_literal: true

require "bigdecimal"

RSpec.describe Jobready::Coding::Test::TaxCalculator do
  it "calculates correctly on a non-imported book" do
    line_item = Jobready::Coding::Test::LineItem.new("1", "book", "12.49")

    expect(subject.calculate(line_item)).to eq(0)
  end

  it "calculates correctly on a non-imported music CD" do
    line_item = Jobready::Coding::Test::LineItem.new("1", "music CD", "14.99")

    expect(subject.calculate(line_item)).to eq(BigDecimal("1.50"))
  end

  it "calculates correctly on a imported book" do
    line_item = Jobready::Coding::Test::LineItem.new("1", "imported book", "12.49")

    expect(subject.calculate(line_item)).to eq(BigDecimal("0.65"))
  end

  it "calculates correctly on a imported music CD" do
    line_item = Jobready::Coding::Test::LineItem.new("1", "imported music CD", "14.99")

    expect(subject.calculate(line_item)).to eq(BigDecimal("2.25"))
  end

  it "works for round numbers too" do
    line_item = Jobready::Coding::Test::LineItem.new("1", "imported music CD", "15.00")

    expect(subject.calculate(line_item)).to eq(BigDecimal("2.25"))
  end
end
