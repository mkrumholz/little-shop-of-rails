require 'rails_helper'

RSpec.describe 'Merchant Invoices Index' do
  describe 'index page' do
    before :each do
      allow(GithubService).to receive(:contributors_info).and_return([
                                                                       { id: 26797256, name: 'Molly', contributions: 7 },
                                                                       { id: 78388882, name: 'Sid', contributions: 80 }
                                                                     ])
      allow(GithubService).to receive(:pull_request_info).and_return([
                                                                  { id: 0o101010011, name: 'Molly', merged_at: 7 },
                                                                  { id: 0o1011230011, name: 'Sid', merged_at: 80 },
                                                                  { id: 0o1011230011, name: 'Sid', merged_at: nil }
                                                                ])
      allow(GithubService).to receive(:repo_info).and_return({
                                                               name: 'little-esty-shop'
                                                             })
    end

    it 'can see all of the invoices that include at least one of my merchants items' do
      merchant = Merchant.create!(name: 'Schroeder-Jerde')
      merchant_2 = Merchant.create!(name: 'James Bond')
      customer_2 = Customer.create!(first_name: 'Evan', last_name: 'East')
      item_1 = merchant.items.create!(name: 'Gold Ring', description: 'Jewelery', unit_price: 10000)
      item_4 = merchant.items.create!(name: 'Hair Clip', description: 'Accessories', unit_price: 200)
      item_2 = merchant.items.create!(name: 'Silver Ring', description: 'Jewelery', unit_price: 5000)
      item_3 = merchant.items.create!(name: 'Hoop Earrings', description: 'Jewelery', unit_price: 1000)
      item_5 = merchant_2.items.create!(name: 'Silver Bracelet', description: 'Accessories', unit_price: 3000)
      item_6 = merchant_2.items.create!(name: 'Bronze Ring', description: 'Jewelery', unit_price: 2000)
      invoice_1 = customer_2.invoices.create!(status: 1, created_at: '2012-03-06 14:54:15 UTC')
      invoice_4 = customer_2.invoices.create!(status: 1, created_at: '2012-03-09 14:54:15 UTC')
      invoice_2 = customer_2.invoices.create!(status: 1, created_at: '2012-03-07 00:54:24 UTC')
      invoice_3 = customer_2.invoices.create!(status: 1, created_at: '2012-03-08 14:54:15 UTC')
      invoice_5 = customer_2.invoices.create!(status: 1, created_at: '2012-03-10 14:54:15 UTC')
      invoice_6 = customer_2.invoices.create!(status: 1, created_at: '2012-03-11 14:54:15 UTC')
      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, status: 1)
      invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, status: 1)
      invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, status: 1)
      invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, status: 1)
      invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, status: 1)
      invoice_item_6 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_6.id, status: 2)

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
