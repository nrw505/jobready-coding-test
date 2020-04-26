# frozen_string_literal: true

RSpec.describe Jobready::Coding::Test::Basket do
  subject { Jobready::Coding::Test::Basket.new(input) }

  context "Example 1" do
    let :input do
      <<EXAMPLE1
Quantity, Product, Price
1, book, 12.49
1, music cd, 14.99
1, chocolate bar, 0.85
EXAMPLE1
    end

    it "extracts line items from the CSV" do
      expect(subject.line_items.count).to eq 3
      expect(subject.line_items[0].description).to eq "book"
      expect(subject.line_items[0].quantity).to eq 1
      expect(subject.line_items[0].price).to eq BigDecimal("12.49")
    end
  end

  context "Example 2" do
    let :input do
      <<EXAMPLE2
Quantity, Product, Price
1, imported box of chocolates, 10.00
1, imported bottle of perfume, 47.50
EXAMPLE2
    end

    it "extracts line items from the CSV" do
      expect(subject.line_items.count).to eq 2
      expect(subject.line_items[1].description).to eq "imported bottle of perfume"
      expect(subject.line_items[1].quantity).to eq 1
      expect(subject.line_items[1].price).to eq BigDecimal("47.50")
    end
  end

  context "Example 3" do
    let :input do
      <<EXAMPLE3
Quantity, Product, Price
1, imported bottle of perfume, 27.99
1, bottle of perfume, 18.99
1, packet of headache pills, 9.75
1, box of imported chocolates, 11.25
EXAMPLE3
    end

    it "extracts line items from the CSV" do
      expect(subject.line_items.count).to eq 4
      expect(subject.line_items[3].description).to eq "box of imported chocolates"
      expect(subject.line_items[3].quantity).to eq 1
      expect(subject.line_items[3].price).to eq BigDecimal("11.25")
    end
  end

end
