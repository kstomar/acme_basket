# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ThresholdBased do
  let(:rule) do
    described_class.new([
                          { min: 90, charge: 0 },
                          { min: 50, charge: 2.95 },
                          { min: 0,  charge: 4.95 }
                        ])
  end

  it 'returns correct delivery cost for total under $50' do
    expect(rule.calculate(49.99)).to eq(4.95)
  end

  it 'returns correct delivery cost for total between $50 and $90' do
    expect(rule.calculate(75.00)).to eq(2.95)
  end

  it 'returns free delivery for total over $90' do
    expect(rule.calculate(120.00)).to eq(0.0)
  end

  it 'returns lowest matching threshold cost' do
    expect(rule.calculate(50.0)).to eq(2.95)
  end
end
