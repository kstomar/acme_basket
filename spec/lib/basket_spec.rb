# frozen_string_literal: true

require 'spec_helper'

describe Basket do
  let(:products) do
    [
      Product.new(code: 'R01', name: 'Red Widget', price: 32.95),
      Product.new(code: 'G01', name: 'Green Widget', price: 24.95),
      Product.new(code: 'B01', name: 'Blue Widget', price: 7.95)
    ]
  end

  let(:catalogue) { Catalogue.new(products) }

  let(:delivery_rule) do
    ThresholdBased.new([
                         { min: 90, charge: 0 },
                         { min: 50, charge: 2.95 },
                         { min: 0,  charge: 4.95 }
                       ])
  end

  let(:offers) { [BuyOneGetHalfOff.new('R01')] }

  it 'returns correct total for B01, G01' do
    basket = described_class.new(catalogue: catalogue, delivery_rule: delivery_rule, offers: offers)
    %w[B01 G01].each { |code| basket.add(code) }
    expect(basket.total).to eq(37.85)
  end

  it 'returns correct total for R01, R01' do
    basket = described_class.new(catalogue: catalogue, delivery_rule: delivery_rule, offers: offers)
    %w[R01 R01].each { |code| basket.add(code) }
    expect(basket.total).to eq(54.37)
  end

  it 'returns correct total for R01, G01' do
    basket = described_class.new(catalogue: catalogue, delivery_rule: delivery_rule, offers: offers)
    %w[R01 G01].each { |code| basket.add(code) }
    expect(basket.total).to eq(60.85)
  end

  it 'returns correct total for B01, B01, R01, R01, R01' do
    basket = described_class.new(catalogue: catalogue, delivery_rule: delivery_rule, offers: offers)
    %w[B01 B01 R01 R01 R01].each { |code| basket.add(code) }
    expect(basket.total).to eq(98.27)
  end

  it 'raises error for unknown product code' do
    basket = described_class.new(catalogue: catalogue, delivery_rule: delivery_rule, offers: offers)
    expect { basket.add('XYZ') }.to raise_error(ArgumentError, /Unknown product code/)
  end

  it 'raises error if offers is not an array' do
    expect do
      Basket.new(catalogue: catalogue, delivery_rule: delivery_rule, offers: nil)
    end.to raise_error(ArgumentError, /offers must be an array/)
  end
end
