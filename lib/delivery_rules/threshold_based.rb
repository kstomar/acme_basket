# frozen_string_literal: true

# convention:Style/Documentation
class ThresholdBased
  def initialize(thresholds)
    @thresholds = thresholds.sort_by { |t| t[:min] }
  end

  def calculate(subtotal)
    rule = @thresholds.reverse.find { |r| subtotal >= r[:min] }
    rule ? rule[:charge] : 0
  end
end
