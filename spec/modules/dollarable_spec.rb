require 'rails_helper'

RSpec.describe Dollarable do
  include Dollarable
  
  describe '#price_in_dollars' do
    it 'takes a price in cents as an integer and converts to dollars as a float' do
      expect(price_in_dollars(15750)).to eq 157.5
      expect(price_in_dollars(1575)).to eq 15.75
      expect(price_in_dollars(157500)).to eq 1575.0
    end
  end

  describe '#price_to_cents' do
    it 'takes a price in dollars as a string (from params) and converts to cents as an integer' do
      expect(price_to_cents('157.50')).to eq 15750
      expect(price_to_cents('15.75')).to eq 1575
      expect(price_to_cents('1575.0')).to eq 157500
    end
  end
end