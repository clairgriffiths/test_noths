require 'spec_helper'
require 'pry'

  describe Checkout do
    let(:checkout_travel_card) {Checkout.new("travel_card_discount")}
    let(:checkout_ten_percent) {Checkout.new("ten_percent_off_60")}
    let(:checkout_both_promotions) {Checkout.new(["travel_card_discount", "ten_percent_off_60"])}
    let(:item_001) {Product.new("001", "Travel Card Holder", 9.25)}
    let(:item_002) {Product.new("002", "Personalised cufflinks", 45.00)}
    let(:item_003) {Product.new("003", "Kids T-Shirt", 19.95)}


    describe "#new" do
      it "instantiates a new instance of Checkout " do
        expect(checkout_travel_card).to be_an_instance_of(Checkout)
      end

      it "instantiates with an items empty array" do
        expect(checkout_travel_card.basket).to eq([])
      end

      it "instantiates with an total of 0" do
        expect(checkout_travel_card.total).to eq(0)
      end
    end

    describe "#scan" do
      it "adds a product to checkout items" do
        checkout_travel_card.scan(item_001)
        expect(checkout_travel_card.basket.first.name).to eq("Travel Card Holder")
      end
    end

    describe "#promotion_exists?" do
      it "returns true if a promotion has been passed as a parameter" do
        expect(checkout_travel_card.promotion_exists?("travel_card_discount")).to be true
      end
      it "returns false if a promotion has not been passed as a parameter" do
        expect(checkout_travel_card.promotion_exists?("dummy_promotion")).to be false
      end
    end

    describe "#more_than_one_travel_card_holder?" do
      it "returns false if one or less travel card holders are in basket" do
        expect(checkout_travel_card.more_than_one_travel_card_holder?).to be false
      end
    end

    it "returns true if more than 1 travel card holders are in basket" do
      checkout_travel_card.scan(item_001)
      checkout_travel_card.scan(item_001)
      expect(checkout_travel_card.more_than_one_travel_card_holder?).to be true
    end

    describe "#travel_card_discount" do
      it "changes price of travel card to 8.50 if basket has more than one" do
        checkout_travel_card.scan(item_001)
        checkout_travel_card.scan(item_001)
        checkout_travel_card.travel_card_discount
        expect(checkout_travel_card.basket.map(&:price_in_pence).reduce(:+)).to eq(1700)
      end
    end

    describe "#calculate_total" do
      it "calculates total of basket" do
        checkout_ten_percent.scan(item_002)
        checkout_ten_percent.scan(item_002)
        checkout_ten_percent.calculate_total
        expect(checkout_ten_percent.calculate_total).to eq(9000)
      end
    end

    describe "#total_greater_than_60?" do
      it "returns true if the total is greater than 60" do
        checkout_ten_percent.scan(item_002)
        checkout_ten_percent.scan(item_002)
        checkout_ten_percent.calculate_total
        expect(checkout_ten_percent.total_greater_than_60?).to be true
      end
    end

    describe "#ten_percent_off_60" do
      it "discounts total by 10% if total is greater than 60" do
        checkout_ten_percent.scan(item_002)
        checkout_ten_percent.scan(item_002)
        checkout_ten_percent.calculate_total
        expect(checkout_ten_percent.ten_percent_off_60).to eq(8100.0)
      end
    end

    describe "#total" do
      context "with 1 of each product" do
        it "returns 66.78" do
          checkout_both_promotions.scan(item_001)
          checkout_both_promotions.scan(item_002)
          checkout_both_promotions.scan(item_003)
          expect(checkout_both_promotions.total).to eq(66.78)
        end
      end
    end

    context "with 2 travelcards and a kids t-shirt" do
      it "returns 36.95" do
        checkout_both_promotions.scan(item_001)
        checkout_both_promotions.scan(item_001)
        checkout_both_promotions.scan(item_003)
        expect(checkout_both_promotions.total).to eq(36.95)
      end
    end

    context "with 2 travelcards, a kids tshirt and cufflinks" do
      it "returns 73.76" do
        checkout_both_promotions.scan(item_001)
        checkout_both_promotions.scan(item_001)
        checkout_both_promotions.scan(item_002)
        checkout_both_promotions.scan(item_003)
        expect(checkout_both_promotions.total).to eq(73.76)
      end
    end

end
