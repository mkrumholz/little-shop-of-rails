require 'rails_helper'

RSpec.describe Invoice do
  describe 'relationships' do
    it { should have_many(:invoice_items).dependent(:destroy) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:transactions) }
  end

  describe 'validations' do
    it { should validate_presence_of(:customer_id) }
    it { should validate_presence_of(:status) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values([:in_progress, :completed, :cancelled]) }
  end

  before :each do
    @merchant_1 = Merchant.create!(name: "Ralph's Monkey Hut")
    @customer_1 = Customer.create!(first_name: 'Madi', last_name: 'Johnson')
    @customer_2 = Customer.create!(first_name: 'Emmy', last_name: 'Lost')
    @customer_3 = Customer.create!(first_name: 'Shim', last_name: 'Stalone')
    @customer_4 = Customer.create!(first_name: 'Bado', last_name: 'Reason')
    @customer_5 = Customer.create!(first_name: 'Timothy', last_name: 'Richard')
    @customer_6 = Customer.create!(first_name: 'Alex', last_name: '19th')
    @invoice_1 = @customer_1.invoices.create!(status: 1)
    @invoice_2 = @customer_2.invoices.create!(status: 1)
    @invoice_3 = @customer_3.invoices.create!(status: 1)
    @invoice_4 = @customer_4.invoices.create!(status: 1)
    @invoice_5 = @customer_5.invoices.create!(status: 1)
    @invoice_6 = @customer_6.invoices.create!(status: 1)
    @item_1 = @merchant_1.items.create!(name: 'Pogs', description: 'Stack of pogs.', unit_price: 500)
    InvoiceItem.create!(quantity: 15, unit_price: 550, status: 0, item: @item_1, invoice: @invoice_1)
    InvoiceItem.create!(quantity: 2, unit_price: 550, status: 2, item: @item_1, invoice: @invoice_1)
    InvoiceItem.create!(quantity: 1, unit_price: 550, status: 0, item: @item_1, invoice: @invoice_2)
    InvoiceItem.create!(quantity: 1, unit_price: 550, status: 0, item: @item_1, invoice: @invoice_3)
    InvoiceItem.create!(quantity: 1, unit_price: 550, status: 0, item: @item_1, invoice: @invoice_4)
    InvoiceItem.create!(quantity: 2, unit_price: 550, status: 2, item: @item_1, invoice: @invoice_5)
    InvoiceItem.create!(quantity: 2, unit_price: 550, status: 2, item: @item_1, invoice: @invoice_6)
    InvoiceItem.create!(quantity: 1, unit_price: 550, status: 0, item: @item_1, invoice: @invoice_6)
  end

  describe 'class methods' do
    describe '#unshipped_items' do
      it 'returns a collection of invoices that have unshipped items' do
        expect(Invoice.unshipped_items.first.customer_id).to eq(@customer_1.id)
        expect(Invoice.unshipped_items.length).to eq(5)
        expect(Invoice.unshipped_items.ids.include?(@invoice_5.id)).to eq(false)
      end
    end
  end

  describe 'instance methods' do
    describe '.item_sale_price' do
      it 'returns all items from an invoice and the amount they sold for and number sold' do
        actual = @invoice_1.item_sale_price.first

        expect(actual.sale_price).to eq(550)
        expect(actual.sale_quantity).to eq(15)
      end
    end

    describe '.total_revenue' do
      it 'returns all items from an invoice and the amount they sold for and number sold' do
        actual = @invoice_1.total_revenue

        expect(actual).to eq(9350)
      end
    end

    describe '.total_revenue_for_merchant' do
      it 'returns the total revenue expected for the invoice only for items belonging to given merchant' do
        merchant = Merchant.create!(name: 'Little Shop of Horrors')
        merchant_2 = Merchant.create!(name: 'James Bond')

        customer = Customer.create!(first_name: 'Audrey', last_name: 'I')
        invoice_1 = customer.invoices.create!(status: 1, updated_at: '2021-03-01')

        # my items on invoice
        item_1 = merchant.items.create!(name: 'Audrey II', description: 'Large, man-eating plant', unit_price: '100000000', enabled: true)
        item_2 = merchant.items.create!(name: 'Bouquet of roses', description: '12 red roses', unit_price: '1900', enabled: true)
        item_4 = merchant.items.create!(name: 'Echevaria', description: 'Peacock varietal', unit_price: '3100', enabled: true)

        # other merchant items on invoice
        item_8 = merchant_2.items.create!(name: 'Silver Bracelet', description: 'Accessories', unit_price: 3000)
        item_9 = merchant_2.items.create!(name: 'Bronze Ring', description: 'Jewelery', unit_price: 2000)

        # $320 for my revenue
        invoice_item_1 = item_1.invoice_items.create!(invoice_id: invoice_1.id, quantity: 2, unit_price: 10000, status: 0) # $200
        invoice_item_2 = item_2.invoice_items.create!(invoice_id: invoice_1.id, quantity: 2, unit_price: 5000, status: 0) # $100
        invoice_item_3 = item_4.invoice_items.create!(invoice_id: invoice_1.id, quantity: 2, unit_price: 1000, status: 0) # $20

        # $100 in other merchant's revenue
        invoice_item_9a = InvoiceItem.create!(quantity: 2, unit_price: 3000, item_id: item_8.id, invoice_id: invoice_1.id, status: 1) # Other merchant rev
        invoice_item_9b = InvoiceItem.create!(quantity: 2, unit_price: 2000, item_id: item_9.id, invoice_id: invoice_1.id, status: 2) # Other merchant rev

        actual = invoice_1.total_revenue_for_merchant(merchant.id)

        expect(actual).to eq(32000)
      end
    end
  end
end
