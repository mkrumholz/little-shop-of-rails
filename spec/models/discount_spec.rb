require 'rails_helper'

RSpec.describe Discount do
  describe 'relationships' do
    it {should belong_to(:merchant)}
  end

  describe 'validations' do
    subject { Discount.new(name: '11th item free', percentage: 0.0909, quantity_threshold: 11) }
    it {should validate_presence_of :name}
    it {should validate_presence_of :percentage}
    it {should validate_presence_of :quantity_threshold}
    it {should validate_uniqueness_of(:name)}
    it {should validate_numericality_of(:percentage).is_less_than_or_equal_to(1.0)}
    it {should validate_numericality_of(:percentage).is_greater_than_or_equal_to(0.0)}
    it {should validate_numericality_of(:quantity_threshold).only_integer}
  end
end
