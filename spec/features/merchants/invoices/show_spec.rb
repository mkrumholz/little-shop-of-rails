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
      merchant_2 = Merchant.create!(name: 'James Bond')
      item_1 = merchant.items.create!(name: 'Gold Ring', description: 'Jewelery', unit_price: 10000)
      item_4 = merchant.items.create!(name: 'Hair Clip', description: 'Accessories', unit_price: 200)
      item_2 = merchant.items.create!(name: 'Silver Ring', description: 'Jewelery', unit_price: 5000)
      item_3 = merchant.items.create!(name: 'Hoop Earrings', description: 'Jewelery', unit_price: 1000)
      item_5 = merchant_2.items.create!(name: 'Silver Bracelet', description: 'Accessories', unit_price: 3000)
      item_6 = merchant_2.items.create!(name: 'Bronze Ring', description: 'Jewelery', unit_price: 2000)
      invoice_1 = item_1.invoices.create!(status: 1, created_at: "2012-03-06 14:54:15 UTC")
      invoice_4 = item_4.invoices.create!(status: 1, created_at: "2012-03-09 14:54:15 UTC")
      invoice_2 = item_2.invoices.create!(status: 1, created_at: "2012-03-07 00:54:24 UTC")
      invoice_3 = item_3.invoices.create!(status: 1, created_at: "2012-03-08 14:54:15 UTC")
      invoice_5 = item_5.invoices.create!(status: 1, created_at: "2012-03-10 14:54:15 UTC")
      invoice_6 = item_6.invoices.create!(status: 1, created_at: "2012-03-11 14:54:15 UTC")
      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, status: 1)
      invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, status: 1)
      invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, status: 1)
      invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, status: 1)
      invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, status: 1)
      invoice_item_6 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_6.id, status: 2)
      #need customer instance variables
      visit "/merchants/#{merchant.id}/invoices"

      expect(page).to have_content(invoice_1.id)
      expect(page).to have_link("Invoice ##{invoice_1.id}")
      expect(page).to have_content(invoice_2.id)
      expect(page).to have_link("Invoice ##{invoice_2.id}")
      expect(page).to have_content(invoice_3.id)
      expect(page).to have_link("Invoice ##{invoice_3.id}")
      expect(page).to have_content(invoice_4.id)
      expect(page).to have_link("Invoice ##{invoice_4.id}")
      expect(page).to_not have_content(invoice_5.id)
      expect(page).to_not have_link("Invoice ##{invoice_5.id}")
      expect(page).to_not have_content(invoice_6.id)
      expect(page).to_not have_link("Invoice ##{invoice_6.id}")
    end
  end
end
