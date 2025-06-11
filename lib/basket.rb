# frozen_string_literal: true

# convention:Style/Documentation
class Basket
  def initialize(catalogue:, delivery_rule:, offers: [])
    raise ArgumentError, 'offers must be an array' unless offers.is_a?(Array)

    @catalogue = catalogue
    @delivery_rule = delivery_rule
    @offers = offers
    @items = []
  end

  def add(product_code)
    product = @catalogue.find(product_code)
    raise ArgumentError, "Unknown product code #{product_code}" unless product

    @items << product
  end

  # Returns the final total after applying discounts and delivery charges.
  def total
    (subtotal - discount + delivery_cost).round(2)
  end

  private

  def subtotal
    @subtotal ||= @items.sum(&:price).round(2)
  end

  def discount
    @discount ||= @offers.sum { |offer| offer.apply(@items) }.round(2)
  end

  def delivery_cost
    @delivery_rule.calculate(subtotal - discount).round(2)
  end
end
