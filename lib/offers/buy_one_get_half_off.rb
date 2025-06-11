# frozen_string_literal: true

# convention:Style/Documentation
class BuyOneGetHalfOff < BaseOffer
  def initialize(product_code)
    super()
    @product_code = product_code
  end

  def apply(items)
    matching_items = items.select { |item| item.code == @product_code }
    val = (matching_items.size / 2) * (matching_items.any? ? matching_items.first.price / 2.0 : 0)
    val.round(2)
  end
end
