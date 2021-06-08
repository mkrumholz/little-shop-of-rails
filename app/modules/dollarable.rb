module Dollarable
  def price_in_dollars(price_in_cents)
    (BigDecimal(price_in_cents)/100).to_f
  end

  def price_to_cents(price_in_dollars)
    (BigDecimal(price_in_dollars) * 100).to_i
  end
end
