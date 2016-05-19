class Product

attr_accessor :product_code, :name, :price_in_pence

  def initialize(product_code, name, price)
    @product_code = product_code
    @name = name
    @price_in_pence = (price * 100).round
  end

end
