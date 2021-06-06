require 'rails_helper'

RSpec.describe Invoice do
  describe 'relationships' do

    it { should have_many(:invoice_items).dependent(:destroy) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:transactions) }

  end


  describe 'enums' do
    it { should define_enum_for(:status).with_values([:in_progress, :completed, :cancelled])}
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
    @item_1 = @merchant_1.items.create!(name: 'Pogs', description: 'Stack of pogs.', unit_price: 500,)
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
  end
end
