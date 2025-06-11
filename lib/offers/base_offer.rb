# frozen_string_literal: true

# convention:Style/Documentation
class BaseOffer
  def apply(product, quantity)
    raise NotImplementedError, "#{self.class} must implement #apply"
  end
end
