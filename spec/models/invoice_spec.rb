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
    describe '#item_sale_price' do
      it 'returns all items from an invoice and the amount they sold for and number sold' do
        actual = @invoice_1.item_sale_price.first

        expect(actual.sale_price).to eq(550)
        expect(actual.sale_quantity).to eq(15)
      end
    end

    describe '#items_with_discounts' do
      it 'returns all items on the invoice for a given merchant along with which discounts were applied' do
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

        expect(invoice_1.items_with_discounts(merchant_1.id).first.item_name).to eq item_1.name
        expect(invoice_1.items_with_discounts(merchant_1.id).first.unit_price).to eq invoice_item_1.unit_price
        expect(invoice_1.items_with_discounts(merchant_1.id).first.status).to eq invoice_item_1.status
        expect(invoice_1.items_with_discounts(merchant_1.id).first.discount_id).to be_nil

        expect(invoice_1.items_with_discounts(merchant_1.id).second.item_name).to eq item_2.name
        expect(invoice_1.items_with_discounts(merchant_1.id).second.unit_price).to eq invoice_item_2.unit_price
        expect(invoice_1.items_with_discounts(merchant_1.id).second.status).to eq invoice_item_2.status
        expect(invoice_1.items_with_discounts(merchant_1.id).second.discount_id).to eq discount_1.id

        expect(invoice_1.items_with_discounts(merchant_1.id).third.item_name).to eq item_3.name
        expect(invoice_1.items_with_discounts(merchant_1.id).third.unit_price).to eq invoice_item_3.unit_price
        expect(invoice_1.items_with_discounts(merchant_1.id).third.status).to eq invoice_item_3.status
        expect(invoice_1.items_with_discounts(merchant_1.id).third.discount_id).to eq discount_3.id

        expect(invoice_1.items_with_discounts(merchant_1.id)).to_not include(invoice_item_5)
      end
    end

    describe '#total_revenue' do
      it 'returns the total (non-discounted) revenue for the whole invoice' do
        expect(@invoice_1.total_revenue).to eq(9350)
      end
    end

    describe '#discounted_total' do
      it 'returns the total revenue with discounts factored in for the whole invoice' do
        merchant_1 = Merchant.create!(name: 'Schroeder-Jerde')
        merchant_2 = Merchant.create!(name: 'James Bond')

        customer_1 = Customer.create!(first_name: 'Sally', last_name: 'Shopper')
        customer_2 = Customer.create!(first_name: 'Evan', last_name: 'East')

        invoice_1 = customer_1.invoices.create!(status: 1, updated_at: '2021-03-01')
        invoice_2 = customer_2.invoices.create!(status: 1, created_at: '2012-03-07 00:54:24 UTC')

        # merchant #1 items
        item_1 = create(:item, merchant: merchant_1, unit_price: 10005)
        item_2 = create(:item, merchant: merchant_1, unit_price: 5005)
        item_3 = create(:item, merchant: merchant_1, unit_price: 1005)
        item_4 = create(:item, merchant: merchant_1, unit_price: 205)

        # merchant #2 items
        item_5 = create(:item, merchant: merchant_2, unit_price: 3005)
        item_6 = create(:item, merchant: merchant_2, unit_price: 2005)

        # merchant #1 discounts
        discount_1 = merchant_1.discounts.create!(name: '4 or More', percentage: 0.1, quantity_threshold: 4)
        discount_2 = merchant_1.discounts.create!(name: '5+ get 15%', percentage: 0.18, quantity_threshold: 5) # should not apply, half dozen is the better discount
        discount_3 = merchant_1.discounts.create!(name: 'Half dozen discount', percentage: 0.2, quantity_threshold: 6)

        # merchant #2 discounts
        discount_4 = merchant_2.discounts.create!(name: '5 Plus', percentage: 0.1, quantity_threshold: 5)

        # merchant 1 items for invoice 1
        invoice_item_1 = InvoiceItem.create!(quantity: 2, unit_price: 10000, item_id: item_1.id, invoice_id: invoice_1.id, status: 1) # $200, no discount
        invoice_item_2 = InvoiceItem.create!(quantity: 4, unit_price: 5000, item_id: item_2.id, invoice_id: invoice_1.id, status: 1) # $200 srp, discount_1, $180 sale price
        invoice_item_3 = InvoiceItem.create!(quantity: 6, unit_price: 1000, item_id: item_3.id, invoice_id: invoice_1.id, status: 1) # $60 srp, discount_3, $48 sale price

        # merchant 2 items for invoice 1
        invoice_item_5 = InvoiceItem.create!(quantity: 2, unit_price: 3000, item_id: item_5.id, invoice_id: invoice_1.id, status: 1) # $60, no discount
        invoice_item_6 = InvoiceItem.create!(quantity: 5, unit_price: 2000, item_id: item_6.id, invoice_id: invoice_1.id, status: 2) # $100 srp, discount_4, $90 sale price

        # item for different invoice (shouldn't count)
        invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 200, item_id: item_4.id, invoice_id: invoice_2.id, status: 1) # should not be counted on invoice 1

        expect(invoice_1.total_revenue).to eq(62000)
        expect(invoice_1.discounted_total).to eq(57800)
      end
    end

    describe 'merchant rev methods' do
      describe '#total_revenue_for_merchant' do
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

      describe '#discounted_revenue_for_merchant' do
        it 'displays the total expected discounted revenue for the merchant' do
          merchant_1 = Merchant.create!(name: 'Little Shop of Horrors')
          merchant_2 = Merchant.create!(name: 'James Bond')

          customer_1 = Customer.create!(first_name: 'Audrey', last_name: 'I')
          customer_2 = Customer.create!(first_name: 'Evan', last_name: 'East')

          invoice_1 = customer_1.invoices.create!(status: 1, updated_at: '2021-03-01')
          invoice_2 = customer_2.invoices.create!(status: 1, created_at: '2012-03-07 00:54:24 UTC')

          # my items on invoice
          item_1 = merchant_1.items.create!(name: 'Audrey II', description: 'Large, man-eating plant', unit_price: '100000000', enabled: true)
          item_2 = merchant_1.items.create!(name: 'Bouquet of roses', description: '12 red roses', unit_price: '1900', enabled: true)
          item_3 = merchant_1.items.create!(name: 'Hoop Earrings', description: 'Jewelery', unit_price: 1000)
          item_4 = merchant_1.items.create!(name: 'Echevaria', description: 'Peacock varietal', unit_price: '3100', enabled: true)

          # other merchant items on invoice
          item_5 = merchant_2.items.create!(name: 'Silver Bracelet', description: 'Accessories', unit_price: 3000)
          item_6 = merchant_2.items.create!(name: 'Bronze Ring', description: 'Jewelery', unit_price: 2000)

          # merchant 1 discounts
          discount_1 = merchant_1.discounts.create!(name: '4 or More', percentage: 0.1, quantity_threshold: 4)
          discount_2 = merchant_1.discounts.create!(name: '5+ get 15%', percentage: 0.15, quantity_threshold: 5) # should not apply, half dozen is the better discount
          discount_3 = merchant_1.discounts.create!(name: 'Half dozen discount', percentage: 0.2, quantity_threshold: 6)

          # merchant 1 items for invoice 1
          invoice_item_1 = InvoiceItem.create!(quantity: 2, unit_price: 10000, item_id: item_1.id, invoice_id: invoice_1.id, status: 1) # $200, no discount
          invoice_item_2 = InvoiceItem.create!(quantity: 4, unit_price: 5000, item_id: item_2.id, invoice_id: invoice_1.id, status: 1) # $200 srp, discount_1, $180 sale price
          invoice_item_3 = InvoiceItem.create!(quantity: 6, unit_price: 1000, item_id: item_3.id, invoice_id: invoice_1.id, status: 1) # $60 srp, discount_3, $48 sale price

          # merchant 2 items for invoice 1
          invoice_item_5 = InvoiceItem.create!(quantity: 2, unit_price: 3000, item_id: item_5.id, invoice_id: invoice_1.id, status: 1) # Other merchant rev
          invoice_item_6 = InvoiceItem.create!(quantity: 2, unit_price: 2000, item_id: item_6.id, invoice_id: invoice_1.id, status: 2) # Other merchant rev

          # item for different invoice
          invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 200, item_id: item_4.id, invoice_id: invoice_2.id, status: 1) # should not be counted on invoice 1

          expect(invoice_1.total_revenue_for_merchant(merchant_1.id)).to eq 46000
          expect(invoice_1.discounted_revenue_for_merchant(merchant_1.id)).to eq 42800
        end
      end
    end
  end
end
