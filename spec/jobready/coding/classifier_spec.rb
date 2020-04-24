# frozen_string_literal: true

RSpec.describe Jobready::Coding::Test::Classifier do
  subject { Jobready::Coding::Test::Classifier }

  it "has books as sales tax exempt" do
    expect(subject.is_sales_tax_exempt? "book").to be_truthy
    expect(subject.is_sales_tax_exempt? "books").to be_truthy
    expect(subject.is_sales_tax_exempt? "training books").to be_truthy
    expect(subject.is_sales_tax_exempt? "book of owls").to be_truthy
    expect(subject.is_sales_tax_exempt? "imported book of owls").to be_truthy
  end

  it "has pills as sales tax exempt" do
    expect(subject.is_sales_tax_exempt? "pills").to be_truthy
    expect(subject.is_sales_tax_exempt? "headache pill").to be_truthy
  end

  it "has food (chocolate) as sales tax exempt" do
    expect(subject.is_sales_tax_exempt? "chocolate bar").to be_truthy
    expect(subject.is_sales_tax_exempt? "pack of chocolates").to be_truthy
  end

  it "has random other things as not sales tax exempt" do
    expect(subject.is_sales_tax_exempt? "bar of steel").to_not be_truthy
    expect(subject.is_sales_tax_exempt? "pack of owls").to_not be_truthy
    expect(subject.is_sales_tax_exempt? "bicycle").to_not be_truthy
  end

  it "detects things that are labelled as imported" do
    expect(subject.is_imported? "bar of steel").to_not be_truthy
    expect(subject.is_imported? "pack of owls").to_not be_truthy
    expect(subject.is_imported? "bicycle").to_not be_truthy

    expect(subject.is_imported? "imported bar of steel").to be_truthy
    expect(subject.is_imported? "bar of imported steel").to be_truthy
    expect(subject.is_imported? "pack of imported owls").to be_truthy
    expect(subject.is_imported? "imported bicycle").to be_truthy
  end
end
