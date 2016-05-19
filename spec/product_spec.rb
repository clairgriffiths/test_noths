require 'spec_helper'

  describe Product do
    
  let(:kids_tshirt) {Product.new(001, "Kids tshirt", 19.95)}

  describe "#new" do
    it "instantiates a new instance of Product " do
      expect(kids_tshirt).to be_an_instance_of(Product)
    end
  end

  describe "#product_code" do
    it "returns the product code" do
      expect(kids_tshirt.product_code).to eq(001)
    end
  end

  describe "#name" do
    it "returns the name of the product" do
      expect(kids_tshirt.name).to eq("Kids tshirt")
    end
  end

  describe "#price_in_pence" do
    it "returns the price of the product in pence" do
      expect(kids_tshirt.price_in_pence).to eq(1995)
    end
  end

end