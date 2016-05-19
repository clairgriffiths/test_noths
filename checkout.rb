require_relative 'product'

class Checkout

  attr_accessor :basket, :promotional_rules

  def initialize(promotional_rules)
    @basket = []
    @promotional_rules = promotional_rules
    @total = 0
  end

  def scan(product)
    basket << product
  end

  def promotion_exists?(promotion_name)
    promotional_rules.include?(promotion_name)
  end

  def more_than_one_travel_card_holder?
    basket.map(&:name).count("Travel Card Holder") > 1
  end

  def travel_card_discount
    if promotion_exists?("travel_card_discount") && more_than_one_travel_card_holder?
      basket.each do |product|
        if product.name == "Travel Card Holder"
        product.price_in_pence = 850
        end
      end
    end
  end

  def calculate_total
    @total = basket.map{|product| product.price_in_pence}.reduce(:+)
  end

  def total_greater_than_60?
    @total > 6000
  end

  def ten_percent_off_60
    if promotion_exists?("ten_percent_off_60") && total_greater_than_60?
      @total *= 0.9
    end
  end

  def calculate_total
    @total = basket.map{|product| product.price_in_pence}.reduce(:+)
  end

  def total
    travel_card_discount
    calculate_total
    ten_percent_off_60
    (@total.to_f / 100).round(2)
  end

end

promotional_rules = ["travel_card_discount", "ten_percent_off_60"]
item_001 = Product.new("001", "Travel Card Holder", 9.25)
item_002 = Product.new("002", "Personalised cufflinks", 45.00)
item_003 = Product.new("003", "Kids T-Shirt", 19.95)

co = Checkout.new(promotional_rules)
co.scan(item_001)
co.scan(item_002)
co.scan(item_003)
co.scan(item_001)
price = co.total



