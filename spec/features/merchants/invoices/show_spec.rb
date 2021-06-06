require 'rails_helper'

RSpec.describe 'Merchant Invoices Show Page' do
  describe 'show page' do
    it 'can see all of that merchants invoice info' do
      # Merchant Invoice Show Page
      # As a merchant
      # When I visit my merchant's invoice show page(/merchants/merchant_id/invoices/invoice_id)
      # Then I see information related to that invoice including:
      # - Invoice id
      # - Invoice status
      # - Invoice created_at date in the format "Monday, July 18, 2019"
      # - Customer first and last name
      merchant = Merchant.create!(name: 'Schroeder-Jerde')
      customer_2 = Customer.create!(first_name: 'Evan', last_name: 'East')
      customer_3 = Customer.create!(first_name: 'Yasha', last_name: 'West')
      customer_1 = Customer.create!(first_name: 'Sally', last_name: 'Shopper')
      customer_4 = Customer.create!(first_name: 'Du', last_name: 'North')
      customer_5 = Customer.create!(first_name: 'Polly', last_name: 'South')
      customer_6 = Customer.create!(first_name: 'Sue', last_name: 'Ann')
      item_1 = merchant.items.create!(name: 'Gold Ring', description: 'Jewelery', unit_price: 10000)
      item_4 = merchant.items.create!(name: 'Hair Clip', description: 'Accessories', unit_price: 200)
      item_2 = merchant.items.create!(name: 'Silver Ring', description: 'Jewelery', unit_price: 5000)
      item_3 = merchant.items.create!(name: 'Hoop Earrings', description: 'Jewelery', unit_price: 1000)
      invoice_1 = customer_1.invoices.create!(status: 1, created_at: "2012-03-06 14:54:15 UTC")
      invoice_4 = customer_4.invoices.create!(status: 1, created_at: "2012-03-09 14:54:15 UTC")
      invoice_2 = customer_2.invoices.create!(status: 1, created_at: "2012-03-07 00:54:24 UTC")
      invoice_3 = customer_3.invoices.create!(status: 1, created_at: "2012-03-08 14:54:15 UTC")
      invoice_5 = customer_5.invoices.create!(status: 1, created_at: "2012-03-10 14:54:15 UTC")
      invoice_6 = customer_6.invoices.create!(status: 1, created_at: "2012-03-11 14:54:15 UTC")
      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, status: 1)
      invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, status: 1)
      invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, status: 1)
      invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, status: 1)

      visit "/merchants/#{merchant.id}/invoices/#{invoice_1.id}"
      
      expect(page).to have_content(invoice_1.id)
      expect(page).to have_content(invoice_1.status)
      expect(page).to have_content(invoice_1.created_at.strftime('%A, %B %d, %Y'))
      expect(page).to have_content(customer_1.first_name)
      expect(page).to have_content(customer_1.last_name)
    end
  end
end
