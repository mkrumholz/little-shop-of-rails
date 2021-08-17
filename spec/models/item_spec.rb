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
    it { should_not allow_value(nil).for(:enabled) }
  end

  before :each do
    @merchant = create(:merchant)
    @customer = Customer.create!(first_name: 'Audrey', last_name: 'I')

    @item_1 = @merchant.items.create!(name: 'Audrey II', description: 'Large, man-eating plant', unit_price: '100000000', enabled: true)
    @item_2 = @merchant.items.create!(name: 'Bouquet of roses', description: '12 red roses', unit_price: '1900', enabled: true)
    @item_3 = @merchant.items.create!(name: 'Orchid', description: 'Purple, 3 inches', unit_price: '2700', enabled: false)
    @item_4 = @merchant.items.create!(name: 'Echevaria', description: 'Peacock varietal', unit_price: '3100', enabled: true)
    @item_5 = @merchant.items.create!(name: 'Fourth item', description: '4th best', unit_price: '26400', enabled: true)
    @item_6 = @merchant.items.create!(name: 'Fifth item', description: '5th best', unit_price: '2400', enabled: true)
    @item_7 = @merchant.items.create!(name: 'Sixth item', description: '6th best', unit_price: '50', enabled: true)

    @invoice_1 = @customer.invoices.create!(status: 1, updated_at: Date.parse('2021-03-01')) # is successful and paid
    @invoice_2 = @customer.invoices.create!(status: 0, updated_at: Date.parse('2021-03-05')) # is cancelled
    @invoice_3 = @customer.invoices.create!(status: 2, updated_at: Date.parse('2021-03-05')) # is still in progress, no good transactions
    @invoice_4 = @customer.invoices.create!(status: 1, updated_at: Date.parse('2021-02-08')) # is successful and paid
    @invoice_5 = @customer.invoices.create!(status: 1, updated_at: Date.parse('2021-02-01')) # has no successful transaction

    @invoice_item_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 2, unit_price: 5000, status: 1)
    @invoice_item_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 2, unit_price: 2500, status: 1)
    @invoice_item_3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_4.id, quantity: 2, unit_price: 1000, status: 1)
    @invoice_item_4 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 2, unit_price: 5000, status: 1)
    @invoice_item_5 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_1.id, quantity: 2, unit_price: 5000, status: 0)
    @invoice_item_6 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_5.id, quantity: 2, unit_price: 500, status: 0)
    @invoice_item_7 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_6.id, quantity: 2, unit_price: 200, status: 0)
    @invoice_item_8 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_7.id, quantity: 2, unit_price: 50, status: 0)

    @invoice_1.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
    @invoice_2.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
    @invoice_4.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
    @invoice_5.transactions.create!(result: 0, credit_card_number: '534', credit_card_expiration_date: 'null')
  end

  describe 'class methods' do
    describe '.enabled_only' do
      it 'returns only the items where enabled = true' do
        expect(Item.enabled_only.length).to eq 6
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

    describe '.top_5_by_revenue' do
      it 'returns the top 5 items by revenue generated' do
        expect(Item.top_5_by_revenue).to include @item_1
        expect(Item.top_5_by_revenue).to include @item_2
        expect(Item.top_5_by_revenue).to include @item_4
        expect(Item.top_5_by_revenue).to include @item_5
        expect(Item.top_5_by_revenue).to include @item_6
        expect(Item.top_5_by_revenue).to_not include @item_3
        expect(Item.top_5_by_revenue).to_not include @item_7
      end
    end

    describe '.ready_to_ship' do
      it 'returns only the items where invoice_item status = packaged & sorted by oldest to newest' do
        expect(Item.ready_to_ship.length).to eq 4
        expect(Item.ready_to_ship.first.name).to include(@item_1.name)
        expect(Item.ready_to_ship.second.name).to include(@item_2.name)
        expect(Item.ready_to_ship.third.name).to include(@item_4.name)
        expect(Item.ready_to_ship).to_not include @item_5
      end
    end

    describe '.merchant_invoices' do
      it 'returns only the invoices that include one of my merchants items' do
        expect(Item.merchant_invoices.length).to eq 4
        expect(Item.merchant_invoices.pluck(:invoice_id)).to include(@invoice_1.id, @invoice_4.id, @invoice_2.id, @invoice_3.id)
      end
    end
  end

  describe 'instance methods' do
    describe '#price_to_dollars' do
      it 'displays the price of the item in dollars' do
        expect(@item_1.price_to_dollars).to eq 1000000.0
      end
    end

    describe '#highest_revenue_date' do
      it 'returns the date on which the most revenue was earned for the item' do
        expect(@item_1.highest_revenue_date).to eq Date.parse('2021-03-01')
      end
    end
  end
end
