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
      @item_5 = @merchant.items.create!(name: 'Silver Ring', description: 'Jewelery', unit_price: '2700', enabled: false)
      @invoice_1 = @item_1.invoices.create!(status: 1, created_at: "2012-03-06 14:54:15 UTC")
      @invoice_4 = @item_4.invoices.create!(status: 1, created_at: "2012-03-09 14:54:15 UTC")
      @invoice_2 = @item_2.invoices.create!(status: 1, created_at: "2012-03-07 00:54:24 UTC")
      @invoice_3 = @item_3.invoices.create!(status: 1, created_at: "2012-03-08 14:54:15 UTC")
      @invoice_5 = @item_5.invoices.create!(status: 1, created_at: "2012-03-08 14:54:15 UTC")
      @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, status: 1)
      @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, status: 1)
      @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_3.id, status: 1)
      @invoice_item_4 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_4.id, status: 1)
      @invoice_item_5 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_5.id, status: 0)
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
        expect(Item.disabled_only.length).to eq 2
        expect(Item.disabled_only).to include @item_3
        expect(Item.disabled_only).to_not include @item_1, @item_2, @item_4
      end
    end

    describe '.ready_to_ship' do
      it 'returns only the items where invoice_item status = packaged' do
        expect(Item.ready_to_ship.length).to eq 4
        expect(Item.ready_to_ship).to include @item_1, @item_2, @item_3, @item_4
        expect(Item.ready_to_ship).to_not include @item_5
      end
    end
  end

  describe 'instance methods' do
    before :each do
      @merchant = Merchant.create!(name: "Little Shop of Horrors")
      @item_1 = @merchant.items.create!(name: 'Audrey II', description: 'Large, man-eating plant', unit_price: '100000000')
    end

    describe '#price_to_dollars' do
      it 'displays the price of the item in dollars' do
        expect(@item_1.price_to_dollars).to eq 1000000.0
      end
    end
  end
end
