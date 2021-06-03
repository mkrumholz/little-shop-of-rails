require 'rails_helper'

RSpec.describe Item do
  describe 'relationships' do

    it { should have_many(:invoice_items).dependent(:destroy) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should belong_to(:merchant) }
  end

  describe 'instance methods' do
    before :each do
      @merchant = Merchant.create!(name: "Little Shop of Horrors")
      @item_1 = @merchant.items.create!(name: 'Audrey II', description: 'Large, man-eating plant', unit_price: '100000000')
    end

    describe '#display_price' do
      it 'displays the price of the item in dollars' do
        expect(@item_1.display_price).to eq '$1000000.00'
      end
    end
  end
end
