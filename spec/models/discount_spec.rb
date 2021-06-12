require 'rails_helper'

RSpec.describe Discount do
  describe 'relationships' do
    it {should belong_to(:merchant)}
  end

  describe 'validations' do
    subject { Discount.new(name: '11th item free', percentage: 0.0909, quantity_threshold: 11) }
    it {should validate_presence_of :name, :percentage, :quantity_threshold}
    it {should validate_uniqueness_of(:name)}
    it {should allow_values('0.1392', '1.0000', '0.0000', '0.0001').for(:percentage)}
    it {should_not allow_values('0.09090909', '2384.0', '1.1', '24').for(:percentage).with_message('🛑 Error: Percentage is not properly formatted')}
    it {should validate_numericality_of({:quantity_threshold, only_integer: true}).with_message('🛑 Error: Quantity threshold must be an integer')}
  end
end
