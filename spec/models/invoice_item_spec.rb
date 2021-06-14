require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
    it { should belong_to(:invoice_item).through(:item)}
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values([:pending, :packaged, :shipped]) }
  end

  describe 'class methods' do
    describe '.invoice_items_show' do
      it 'returns all items for a given merchants invoice id' do
        merchant = Merchant.create!(name: 'Schroeder-Jerde')
        merchant_2 = Merchant.create!(name: 'James Bond')
        customer_2 = Customer.create!(first_name: 'Evan', last_name: 'East')
        customer_3 = Customer.create!(first_name: 'Yasha', last_name: 'West')
        customer_1 = Customer.create!(first_name: 'Sally', last_name: 'Shopper')
        customer_4 = Customer.create!(first_name: 'Du', last_name: 'North')
        customer_5 = Customer.create!(first_name: 'Jackie', last_name: 'Chan')
        item_1 = merchant.items.create!(name: 'Gold Ring', description: 'Jewelery', unit_price: 10_000)
        item_4 = merchant.items.create!(name: 'Hair Clip', description: 'Accessories', unit_price: 200)
        item_2 = merchant.items.create!(name: 'Silver Ring', description: 'Jewelery', unit_price: 5000)
        item_3 = merchant.items.create!(name: 'Hoop Earrings', description: 'Jewelery', unit_price: 1000)
        item_5 = merchant_2.items.create!(name: 'Silver Bracelet', description: 'Accessories', unit_price: 3000)
        item_6 = merchant_2.items.create!(name: 'Bronze Ring', description: 'Jewelery', unit_price: 2000)
        invoice_1 = customer_1.invoices.create!(status: 1, created_at: '2012-03-06 14:54:15 UTC')
        invoice_4 = customer_4.invoices.create!(status: 1, created_at: '2012-03-09 14:54:15 UTC')
        invoice_2 = customer_2.invoices.create!(status: 1, created_at: '2012-03-07 00:54:24 UTC')
        invoice_3 = customer_3.invoices.create!(status: 1, created_at: '2012-03-08 14:54:15 UTC')
        invoice_5 = customer_5.invoices.create!(status: 1, created_at: '2012-03-10 14:54:15 UTC')
        invoice_6 = customer_5.invoices.create!(status: 1, created_at: '2012-03-11 14:54:15 UTC')
        invoice_item_1 = InvoiceItem.create!(quantity: 2, unit_price: 10_000, item_id: item_1.id, invoice_id: invoice_1.id, status: 1)
        invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 5000, item_id: item_2.id, invoice_id: invoice_1.id, status: 1)
        invoice_item_3 = InvoiceItem.create!(quantity: 2, unit_price: 1000, item_id: item_3.id, invoice_id: invoice_1.id, status: 1)
        invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 200, item_id: item_4.id, invoice_id: invoice_4.id, status: 1)
        invoice_item_5 = InvoiceItem.create!(quantity: 2, unit_price: 3000, item_id: item_5.id, invoice_id: invoice_1.id, status: 1)
        invoice_item_6 = InvoiceItem.create!(quantity: 2, unit_price: 2000, item_id: item_6.id, invoice_id: invoice_6.id, status: 2)

        expect(InvoiceItem.invoice_items_show(invoice_1.id, merchant.id).first.item_name).to eq item_1.name
        expect(InvoiceItem.invoice_items_show(invoice_1.id, merchant.id).first.unit_price).to eq item_1.unit_price
        expect(InvoiceItem.invoice_items_show(invoice_1.id, merchant.id).first.status).to eq invoice_item_1.status
        expect(InvoiceItem.invoice_items_show(invoice_1.id, merchant.id).second.item_name).to eq item_2.name
        expect(InvoiceItem.invoice_items_show(invoice_1.id, merchant.id).second.unit_price).to eq item_2.unit_price
        expect(InvoiceItem.invoice_items_show(invoice_1.id, merchant.id).second.status).to eq invoice_item_2.status
        expect(InvoiceItem.invoice_items_show(invoice_1.id, merchant.id)).to_not include(item_5)
      end
    end
  end
end
