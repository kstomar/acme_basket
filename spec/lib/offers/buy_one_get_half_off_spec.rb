# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BuyOneGetHalfOff do
  let(:red_widget) { Product.new(code: 'R01', name: 'Red Widget', price: 32.95) }
  let(:green_widget) { Product.new(code: 'G01', name: 'Green Widget', price: 24.95) }
  let(:offer) { described_class.new('R01') }

  describe '#apply' do
    it 'returns 0.0 when no matching products' do
      items = [green_widget, green_widget]
      expect(offer.apply(items)).to eq(0.0)
    end

    it 'returns half price for second matching item' do
      items = [red_widget, red_widget]
      expected_discount = (32.95 / 2).round(2)
      expect(offer.apply(items)).to eq(expected_discount)
    end

    it 'returns correct discount for 3 matching items (1 discount)' do
      items = [red_widget, red_widget, red_widget]
      expected_discount = (32.95 / 2).round(2)
      expect(offer.apply(items)).to eq(expected_discount)
    end

    it 'returns correct discount for 4 matching items (2 discounts)' do
      items = [red_widget, red_widget, red_widget, red_widget]
      expected_discount = ((32.95 / 2) * 2).round(2)
      expect(offer.apply(items)).to eq(expected_discount)
    end

    it 'ignores non-matching items' do
      items = [red_widget, red_widget, green_widget]
      expected_discount = (32.95 / 2).round(2)
      expect(offer.apply(items)).to eq(expected_discount)
    end
  end
end
