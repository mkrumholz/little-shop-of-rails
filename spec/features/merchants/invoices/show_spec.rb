require 'rails_helper'

RSpec.describe 'Merchant Invoices Show Page' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Schroeder-Jerde')
    @merchant_2 = Merchant.create!(name: 'James Bond')

    @customer_1 = Customer.create!(first_name: 'Sally', last_name: 'Shopper')
    @customer_2 = Customer.create!(first_name: 'Evan', last_name: 'East')
    @customer_3 = Customer.create!(first_name: 'Yasha', last_name: 'West')
    @customer_4 = Customer.create!(first_name: 'Du', last_name: 'North')
    @customer_5 = Customer.create!(first_name: 'Jackie', last_name: 'Chan')
    @customer_6 = Customer.create!(first_name: 'Sue', last_name: 'Ann')

    # merchant #1 items
    @item_1 = @merchant_1.items.create!(name: 'Gold Ring', description: 'Jewelery', unit_price: 10000)
    @item_2 = @merchant_1.items.create!(name: 'Silver Ring', description: 'Jewelery', unit_price: 5000)
    @item_3 = @merchant_1.items.create!(name: 'Hoop Earrings', description: 'Jewelery', unit_price: 1000)
    @item_4 = @merchant_1.items.create!(name: 'Hair Clip', description: 'Accessories', unit_price: 200)

    # merchant #2 items
    @item_5 = @merchant_2.items.create!(name: 'Silver Bracelet', description: 'Accessories', unit_price: 3000)
    @item_6 = @merchant_2.items.create!(name: 'Bronze Ring', description: 'Jewelery', unit_price: 2000)

    @invoice_1 = @customer_1.invoices.create!(status: 1, created_at: '2012-03-06 14:54:15 UTC')
    @invoice_2 = @customer_2.invoices.create!(status: 1, created_at: '2012-03-07 00:54:24 UTC')
    @invoice_3 = @customer_3.invoices.create!(status: 1, created_at: '2012-03-08 14:54:15 UTC')
    @invoice_4 = @customer_4.invoices.create!(status: 1, created_at: '2012-03-09 14:54:15 UTC')
    @invoice_5 = @customer_5.invoices.create!(status: 1, created_at: '2012-03-10 14:54:15 UTC')
    @invoice_6 = @customer_6.invoices.create!(status: 1, created_at: '2012-03-11 14:54:15 UTC')
  end

  describe 'show page' do
    it 'can see all of that merchants invoice info' do
      invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, status: 1, unit_price: 10000)
      invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, status: 1, unit_price: 5000)
      invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_3.id, status: 1, unit_price: 1000)
      invoice_item_4 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_4.id, status: 1, unit_price: 200)

      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_select('invoice_item[status]', selected: 'Packaged')
      expect(page).to have_content(@invoice_1.created_at.strftime('%A, %B %d, %Y'))
      expect(page).to have_content(@customer_1.first_name)
      expect(page).to have_content(@customer_1.last_name)
    end

    it 'can see all of that merchants invoice item info' do
      invoice_item_1 = InvoiceItem.create!(quantity: 2, unit_price: 10000, item_id: @item_1.id, invoice_id: @invoice_1.id, status: 1)
      invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 5000, item_id: @item_2.id, invoice_id: @invoice_1.id, status: 1)
      invoice_item_3 = InvoiceItem.create!(quantity: 2, unit_price: 1000, item_id: @item_3.id, invoice_id: @invoice_1.id, status: 1)
      invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 200, item_id: @item_4.id, invoice_id: @invoice_4.id, status: 1)
      invoice_item_5 = InvoiceItem.create!(quantity: 2, unit_price: 3000, item_id: @item_5.id, invoice_id: @invoice_1.id, status: 1)
      invoice_item_6 = InvoiceItem.create!(quantity: 2, unit_price: 2000, item_id: @item_6.id, invoice_id: @invoice_1.id, status: 2)

      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(invoice_item_1.quantity)
      expect(page).to have_content('$100.00')
      expect(page).to have_select('invoice_item[status]', selected: 'Packaged')
      expect(page).to_not have_content(@item_5.name)
    end
    
    it 'can update an invoice item status' do
      invoice_item_1 = InvoiceItem.create!(quantity: 2, unit_price: 10000, item_id: @item_1.id, invoice_id: @invoice_1.id, status: 1)
      invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 5000, item_id: @item_2.id, invoice_id: @invoice_1.id, status: 1)
      
      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"
      
      within "tr#ii-#{invoice_item_1.id}" do
        expect(page).to have_select('invoice_item[status]', selected: 'Packaged')
        
        select 'Shipped', from: 'invoice_item[status]'
        click_button 'Update'
      end
      
      expect(current_path).to eq "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"
      
      within "tr#ii-#{invoice_item_1.id}" do
        expect(page).to have_select('invoice_item[status]', selected: 'Shipped')
      end
    end
    
    it 'displays the total expected revenue (full price) from all of my items on the invoice' do
      # merchant 1 items for invoice 1
      invoice_item_1 = InvoiceItem.create!(quantity: 2, unit_price: 10000, item_id: @item_1.id, invoice_id: @invoice_1.id, status: 1) # $200
      invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 5000, item_id: @item_2.id, invoice_id: @invoice_1.id, status: 1) # $100
      invoice_item_3 = InvoiceItem.create!(quantity: 2, unit_price: 1000, item_id: @item_3.id, invoice_id: @invoice_1.id, status: 1) # $20

      # merchant 2 items for invoice 1
      invoice_item_5 = InvoiceItem.create!(quantity: 2, unit_price: 3000, item_id: @item_5.id, invoice_id: @invoice_1.id, status: 1) # Other merchant rev
      invoice_item_6 = InvoiceItem.create!(quantity: 2, unit_price: 2000, item_id: @item_6.id, invoice_id: @invoice_1.id, status: 2) # Other merchant rev

      # item for different invoice
      invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 200, item_id: @item_4.id, invoice_id: @invoice_2.id, status: 1) # should not be counted on invoice 1

      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

      expect(page).to have_content 'Full price total: $320.00'
    end

    it 'displays the total expected discounted revenue for the merchant' do
      discount_1 = @merchant_1.discounts.create!(name: '4 or More', percentage: 0.1, quantity_threshold: 4)
      discount_2 = @merchant_1.discounts.create!(name: '5+ get 15%', percentage: 0.15, quantity_threshold: 5) # should not apply, half dozen is the better discount
      discount_3 = @merchant_1.discounts.create!(name: 'Half dozen discount', percentage: 0.2, quantity_threshold: 6)

      # merchant 1 items for invoice 1
      invoice_item_1 = InvoiceItem.create!(quantity: 2, unit_price: 10000, item_id: @item_1.id, invoice_id: @invoice_1.id, status: 1) # $200, no discount
      invoice_item_2 = InvoiceItem.create!(quantity: 4, unit_price: 5000, item_id: @item_2.id, invoice_id: @invoice_1.id, status: 1) # $200 srp, discount_1, $180 sale price
      invoice_item_3 = InvoiceItem.create!(quantity: 6, unit_price: 1000, item_id: @item_3.id, invoice_id: @invoice_1.id, status: 1) # $60 srp, discount_3, $48 sale price

      # merchant 2 items for invoice 1
      invoice_item_5 = InvoiceItem.create!(quantity: 2, unit_price: 3000, item_id: @item_5.id, invoice_id: @invoice_1.id, status: 1) # Other merchant rev
      invoice_item_6 = InvoiceItem.create!(quantity: 2, unit_price: 2000, item_id: @item_6.id, invoice_id: @invoice_1.id, status: 2) # Other merchant rev

      # item for different invoice
      invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 200, item_id: @item_4.id, invoice_id: @invoice_2.id, status: 1) # should not be counted on invoice 1

      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

      expect(page).to have_content 'Full price total: $460.00'
      expect(page).to have_content 'Total expected revenue (discounts included): $428.00'
    end
  end
end
