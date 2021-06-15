require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values([:pending, :packaged, :shipped]) }
  end

  describe 'class methods' do
    describe '.with_discounts' do
      it 'returns all items for a given merchants invoice id along with which discounts were applied' do
        merchant_1 = Merchant.create!(name: 'Schroeder-Jerde')
        merchant_2 = Merchant.create!(name: 'James Bond')

        customer_1 = Customer.create!(first_name: 'Sally', last_name: 'Shopper')
        customer_2 = Customer.create!(first_name: 'Evan', last_name: 'East')

        invoice_1 = customer_1.invoices.create!(status: 1, updated_at: '2021-03-01')
        invoice_2 = customer_2.invoices.create!(status: 1, created_at: '2012-03-07 00:54:24 UTC')

        # merchant 1 discounts
        discount_1 = merchant_1.discounts.create!(name: '4 or More', percentage: 0.1, quantity_threshold: 4)
        discount_2 = merchant_1.discounts.create!(name: '5+ get 15%', percentage: 0.15, quantity_threshold: 5) # should not apply, half dozen is the better discount
        discount_3 = merchant_1.discounts.create!(name: 'Half dozen discount', percentage: 0.2, quantity_threshold: 6)

        # my items on invoice
        item_1 = merchant_1.items.create!(name: 'Audrey II', description: 'Large, man-eating plant', unit_price: '100000000', enabled: true)
        item_2 = merchant_1.items.create!(name: 'Bouquet of roses', description: '12 red roses', unit_price: '1900', enabled: true)
        item_3 = merchant_1.items.create!(name: 'Hoop Earrings', description: 'Jewelery', unit_price: 1000)
        item_4 = merchant_1.items.create!(name: 'Echevaria', description: 'Peacock varietal', unit_price: '3100', enabled: true)

        # other merchant items on invoice
        item_5 = merchant_2.items.create!(name: 'Silver Bracelet', description: 'Accessories', unit_price: 3000)
        item_6 = merchant_2.items.create!(name: 'Bronze Ring', description: 'Jewelery', unit_price: 2000)

        # merchant 1 items for invoice 1
        invoice_item_1 = InvoiceItem.create!(quantity: 2, unit_price: 10000, item_id: item_1.id, invoice_id: invoice_1.id, status: 1) # $200, no discount
        invoice_item_2 = InvoiceItem.create!(quantity: 4, unit_price: 5000, item_id: item_2.id, invoice_id: invoice_1.id, status: 1) # $200 srp, discount_1, $180 sale price
        invoice_item_3 = InvoiceItem.create!(quantity: 6, unit_price: 1000, item_id: item_3.id, invoice_id: invoice_1.id, status: 1) # $60 srp, discount_3, $48 sale price
  
        # merchant 2 items for invoice 1
        invoice_item_5 = InvoiceItem.create!(quantity: 2, unit_price: 3000, item_id: item_5.id, invoice_id: invoice_1.id, status: 1) # Other merchant rev
        invoice_item_6 = InvoiceItem.create!(quantity: 2, unit_price: 2000, item_id: item_6.id, invoice_id: invoice_1.id, status: 2) # Other merchant rev
  
        # item for different invoice
        invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 200, item_id: item_4.id, invoice_id: invoice_2.id, status: 1) # should not be counted on invoice 1
  
        expect(InvoiceItem.with_discounts(invoice_1.id, merchant_1.id).first.item_name).to eq item_1.name
        expect(InvoiceItem.with_discounts(invoice_1.id, merchant_1.id).first.unit_price).to eq invoice_item_1.unit_price
        expect(InvoiceItem.with_discounts(invoice_1.id, merchant_1.id).first.status).to eq invoice_item_1.status
        expect(InvoiceItem.with_discounts(invoice_1.id, merchant_1.id).first.discount_id).to be_nil

        expect(InvoiceItem.with_discounts(invoice_1.id, merchant_1.id).second.item_name).to eq item_2.name
        expect(InvoiceItem.with_discounts(invoice_1.id, merchant_1.id).second.unit_price).to eq invoice_item_2.unit_price
        expect(InvoiceItem.with_discounts(invoice_1.id, merchant_1.id).second.status).to eq invoice_item_2.status
        expect(InvoiceItem.with_discounts(invoice_1.id, merchant_1.id).second.discount_id).to eq discount_1.id

        expect(InvoiceItem.with_discounts(invoice_1.id, merchant_1.id).third.item_name).to eq item_3.name
        expect(InvoiceItem.with_discounts(invoice_1.id, merchant_1.id).third.unit_price).to eq invoice_item_3.unit_price
        expect(InvoiceItem.with_discounts(invoice_1.id, merchant_1.id).third.status).to eq invoice_item_3.status
        expect(InvoiceItem.with_discounts(invoice_1.id, merchant_1.id).third.discount_id).to eq discount_3.id

        expect(InvoiceItem.with_discounts(invoice_1.id, merchant_1.id)).to_not include(invoice_item_5)
      end
    end
  end
end
