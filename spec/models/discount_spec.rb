require 'rails_helper'

RSpec.describe Discount do
  describe 'relationships' do
    it { should belong_to(:merchant) }
  end

  describe 'validations' do
    subject { Discount.new(name: '11th item free', percentage: 0.0909, quantity_threshold: 11) }
    it { should validate_presence_of :name }
    it { should validate_presence_of :percentage }
    it { should validate_presence_of :quantity_threshold }
    it { should validate_uniqueness_of(:name) }
    it { should validate_numericality_of(:percentage).is_less_than_or_equal_to(1.0) }
    it { should validate_numericality_of(:percentage).is_greater_than_or_equal_to(0.0) }
    it { should validate_numericality_of(:quantity_threshold).only_integer }
  end

  describe 'class methods' do
    describe '.find_by_holiday' do
      before :each do
        @merchant_1 = create(:merchant)

        @discount_1 = @merchant_1.discounts.create!(name: '4 or More', percentage: 0.1, quantity_threshold: 4)
        @discount_2 = @merchant_1.discounts.create!(name: '5+ get 15%', percentage: 0.18, quantity_threshold: 5) # should not apply, half dozen is the better discount
        @discount_3 = @merchant_1.discounts.create!(name: 'Half dozen discount', percentage: 0.2, quantity_threshold: 6)
      end

      it 'returns the discount for that holiday, if one exists' do
        discount_4 = @merchant_1.discounts.create!(name: 'Independence Day discount', percentage: 0.25, quantity_threshold: 3)

        expect(Discount.find_by_holiday('Independence Day')).to eq discount_4
      end

      it 'returns nil if no discount exists for the holiday' do
        expect(Discount.find_by_holiday('Independence Day')).to be_nil
      end
    end
  end
end
