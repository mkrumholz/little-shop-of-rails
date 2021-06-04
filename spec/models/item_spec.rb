require 'rails_helper'

RSpec.describe Item do
  describe 'relationships' do
    it { should have_many(:invoice_items).dependent(:destroy) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should belong_to(:merchant) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_inclusion_of(:enabled).in_array([true, false]) }
  end
  
  describe 'class methods' do
    before :each do
      @merchant = Merchant.create!(name: "Little Shop of Horrors")
      @item_1 = @merchant.items.create!(name: 'Audrey II', description: 'Large, man-eating plant', unit_price: '100000000', enabled: true)
      @item_2 = @merchant.items.create!(name: 'Bouquet of roses', description: '12 red roses', unit_price: '1900', enabled: true)
      @item_3 = @merchant.items.create!(name: 'Orchid', description: 'Purple, 3 inches', unit_price: '2700', enabled: false)
      @item_4 = @merchant.items.create!(name: 'Echevaria', description: 'Peacock varietal', unit_price: '3100', enabled: true)
    end

    describe '.enabled_only' do
      it 'returns only the items where enabled = true' do
        expect(Item.enabled_only.length).to eq 3
        expect(Item.enabled_only).to include @item_1, @item_2, @item_4
        expect(Item.enabled_only).to_not include @item_3
      end
    end

    describe '.disabled_only' do
      it 'returns only the items where enabled = false' do
        expect(Item.disabled_only.length).to eq 1
        expect(Item.disabled_only).to include @item_3
        expect(Item.disabled_only).to_not include @item_1, @item_2, @item_4
      end
    end
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
