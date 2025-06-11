# frozen_string_literal: true

# convention:Style/Documentation
class Catalogue
  def initialize(products)
    @products = products.each_with_object({}) do |product, hash|
      hash[product.code] = product
    end
  end

  def find(code)
    @products[code]
  end
end
