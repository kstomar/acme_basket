# frozen_string_literal: true

require_relative 'lib/loader'

products = [
  Product.new(code: 'R01', name: 'Red Widget', price: 32.95),
  Product.new(code: 'G01', name: 'Green Widget', price: 24.95),
  Product.new(code: 'B01', name: 'Blue Widget', price: 7.95)
]

catalogue = Catalogue.new(products)

delivery_rule = ThresholdBased.new([
                                     { min: 90, charge: 0 },
                                     { min: 50, charge: 2.95 },
                                     { min: 0,  charge: 4.95 }
                                   ])

offers = [BuyOneGetHalfOff.new('R01')]

basket = Basket.new(catalogue: catalogue, delivery_rule: delivery_rule, offers: offers)

%w[B01 G01].each { |code| basket.add(code) }
puts "Total: $#{basket.total}" # => $37.85
