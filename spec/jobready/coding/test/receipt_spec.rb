# frozen_string_literal: true

RSpec.describe Jobready::Coding::Test::Receipt do
  subject { Jobready::Coding::Test::Receipt.new(Jobready::Coding::Test::Basket.new(input)) }
  let(:tax_calculator) { Jobready::Coding::Test::TaxCalculator.new }

  context "Example 1" do
    let :input do
      <<EXAMPLE1
Quantity, Product, Price
1, book, 12.49
1, music CD, 14.99
1, chocolate bar, 0.85
EXAMPLE1
    end
    let :expected_output do
      <<OUTPUT1
1, book, 12.49
1, music CD, 16.49
1, chocolate bar, 0.85

Sales Taxes: 1.50
Total: 29.83
OUTPUT1
    end

    it "calculates the tax and total" do
      subject.calculate!(tax_calculator)

      expect(subject.tax_total).to eq BigDecimal("1.50")
      expect(subject.total).to eq BigDecimal("29.83")
    end

    it "writes the correct output" do
      subject.calculate!(tax_calculator)

      output = StringIO.new
      subject.write(output)

      expect(output.string).to eq expected_output
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
    let :expected_output do
      <<OUTPUT2
1, imported box of chocolates, 10.50
1, imported bottle of perfume, 54.65

Sales Taxes: 7.65
Total: 65.15
OUTPUT2
    end

    it "calculates the tax and total" do
      subject.calculate!(tax_calculator)

      expect(subject.tax_total).to eq BigDecimal("7.65")
      expect(subject.total).to eq BigDecimal("65.15")
    end

    it "writes the correct output" do
      subject.calculate!(tax_calculator)

      output = StringIO.new
      subject.write(output)

      expect(output.string).to eq expected_output
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
    let :expected_output do
      <<OUTPUT3
1, imported bottle of perfume, 32.19
1, bottle of perfume, 20.89
1, packet of headache pills, 9.75
1, box of imported chocolates, 11.85

Sales Taxes: 6.70
Total: 74.68
OUTPUT3
    end

    it "calculates the tax and total" do
      subject.calculate!(tax_calculator)

      expect(subject.tax_total).to eq BigDecimal("6.70")
      expect(subject.total).to eq BigDecimal("74.68")
    end

    it "writes the correct output" do
      subject.calculate!(tax_calculator)

      output = StringIO.new
      subject.write(output)

      expect(output.string).to eq expected_output
    end
  end

end
