require 'rails_helper'

RSpec.describe 'Dashboard' do
  describe 'dashboard' do
    it 'can see the name of the merchants' do
      # Merchant Dashboard
      # As a merchant,
      # When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
      # Then I see the name of my merchant

      merchant = Merchant.create!(name: 'Schroeder-Jerde')

      visit "/merchants/#{merchant.id}/dashboard"

      expect(page).to have_content(merchant.name)
    end

    it 'can see links to the merchant items & invoice indexes' do
      # Merchant Dashboard Links
      # As a merchant,
      # When I visit my merchant dashboard
      # Then I see link to my merchant items index (/merchants/merchant_id/items)
      # And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)

      merchant = Merchant.create!(name: 'Schroeder-Jerde')

      visit "/merchants/#{merchant.id}/dashboard"

      expect(page).to have_link("My Items")
      expect(page).to have_link("My Invoices")
      # click_link("My Items")
      #
      # expect(page).to have_current_path("/merchants/#{merchant.id}/items")
      #
      # click_link("My Invoices")
      #
      # expect(page).to have_current_path("/merchants/#{merchant.id}/invoices")
    end

    it 'can see the name of the top 5 customers' do
      # Merchant Dashboard Statistics - Favorite Customers
      # As a merchant,
      # When I visit my merchant dashboard
      # Then I see the names of the top 5 customers
      # who have conducted the largest number of successful transactions with my merchant
      # And next to each customer name I see the number of successful transactions they have
      # conducted with my merchant

      merchant = Merchant.create!(name: 'Schroeder-Jerde')
      customer_2 = Customer.create!(first_name: 'Evan', last_name: 'East')
      customer_3 = Customer.create!(first_name: 'Yasha', last_name: 'West')
      customer_1 = Customer.create!(first_name: 'Sally', last_name: 'Shopper')
      customer_4 = Customer.create!(first_name: 'Du', last_name: 'North')
      customer_5 = Customer.create!(first_name: 'Polly', last_name: 'South')
      customer_6 = Customer.create!(first_name: 'Sue', last_name: 'Ann')
      invoice_1 = customer_1.invoices.create!(status: 'completed')
      invoice_2 = customer_2.invoices.create!(status: 'completed')
      invoice_3 = customer_3.invoices.create!(status: 'completed')
      invoice_4 = customer_4.invoices.create!(status: 'completed')
      invoice_5 = customer_5.invoices.create!(status: 'completed')
      invoice_6 = customer_6.invoices.create!(status: 'completed')
      transaction_1 = invoice_1.transactions.create!(credit_card_number: '4111839154983476', credit_card_expiration_date: '11/23', result: 1)
      transaction_2 = invoice_1.transactions.create!(credit_card_number: '4111839154981234', credit_card_expiration_date: '11/24', result: 1)
      transaction_3 = invoice_1.transactions.create!(credit_card_number: '4111839154985673', credit_card_expiration_date: '11/25', result: 1)
      transaction_4 = invoice_1.transactions.create!(credit_card_number: '4111839154989876', credit_card_expiration_date: '11/26', result: 1)
      transaction_5 = invoice_1.transactions.create!(credit_card_number: '4111839154986201', credit_card_expiration_date: '11/27', result: 1)
      transaction_6 = invoice_1.transactions.create!(credit_card_number: '4111839154985551', credit_card_expiration_date: '10/27', result: 1)
      transaction_30 = invoice_1.transactions.create!(credit_card_number: '4111839154983333', credit_card_expiration_date: '09/27', result: 0)
      transaction_7 = invoice_2.transactions.create!(credit_card_number: '4111839154984673', credit_card_expiration_date: '11/28', result: 1)
      transaction_8 = invoice_2.transactions.create!(credit_card_number: '4111839154980980', credit_card_expiration_date: '11/29', result: 1)
      transaction_9 = invoice_2.transactions.create!(credit_card_number: '4111839154983421', credit_card_expiration_date: '11/30', result: 1)
      transaction_10 = invoice_2.transactions.create!(credit_card_number: '4111839154989836', credit_card_expiration_date: '11/31', result: 1)
      transaction_11 = invoice_2.transactions.create!(credit_card_number: '4111839154984365', credit_card_expiration_date: '11/32', result: 1)
      transaction_12 = invoice_3.transactions.create!(credit_card_number: '4111839154987409', credit_card_expiration_date: '11/33', result: 1)
      transaction_13 = invoice_3.transactions.create!(credit_card_number: '4111839154980984', credit_card_expiration_date: '11/34', result: 1)
      transaction_14 = invoice_3.transactions.create!(credit_card_number: '4111839154983721', credit_card_expiration_date: '11/35', result: 1)
      transaction_15 = invoice_3.transactions.create!(credit_card_number: '4111839154987356', credit_card_expiration_date: '11/36', result: 1)
      transaction_16 = invoice_4.transactions.create!(credit_card_number: '4111839154984321', credit_card_expiration_date: '11/37', result: 1)
      transaction_17 = invoice_4.transactions.create!(credit_card_number: '4111839154986543', credit_card_expiration_date: '11/38', result: 1)
      transaction_18 = invoice_4.transactions.create!(credit_card_number: '4111839154988970', credit_card_expiration_date: '11/39', result: 1)
      transaction_19 = invoice_5.transactions.create!(credit_card_number: '4111839154988970', credit_card_expiration_date: '11/40', result: 1)
      transaction_20 = invoice_5.transactions.create!(credit_card_number: '4111839154988970', credit_card_expiration_date: '11/41', result: 1)
      transaction_21 = invoice_6.transactions.create!(credit_card_number: '4111839154984763', credit_card_expiration_date: '11/42', result: 1)

      visit "/merchants/#{merchant.id}/dashboard"

      expect(page).to have_content(customer_1.first_name)
      expect(page).to have_content(customer_1.last_name)
      expect(customer_1.first_name).to appear_before(customer_2.first_name)
      expect(page).to have_content("6 purchases")
      expect(page).to have_content(customer_2.first_name)
      expect(page).to have_content(customer_2.last_name)
      expect(page).to have_content("5 purchases")
      expect(page).to have_content(customer_3.first_name)
      expect(page).to have_content(customer_3.last_name)
      expect(page).to have_content("4 purchases")
      expect(page).to have_content(customer_4.first_name)
      expect(page).to have_content(customer_4.last_name)
      expect(page).to have_content("3 purchases")
      expect(page).to have_content(customer_5.first_name)
      expect(page).to have_content(customer_5.last_name)
      expect(page).to have_content("2 purchases")
      expect(page).to_not have_content(customer_6.first_name)
      expect(page).to_not have_content(customer_6.last_name)
    end

    it 'can see the items ready to ship' do
      # Merchant Dashboard Items Ready to Ship
      # As a merchant
      # When I visit my merchant dashboard
      # Then I see a section for "Items Ready to Ship"
      # In that section I see a list of the names of all of my items that
      # have been ordered and have not yet been shipped,
      # And next to each Item I see the id of the invoice that ordered my item
      # And each invoice id is a link to my merchant's invoice show page

      merchant = Merchant.create!(name: 'Schroeder-Jerde')
      customer_2 = Customer.create!(first_name: 'Evan', last_name: 'East')
      customer_3 = Customer.create!(first_name: 'Yasha', last_name: 'West')
      customer_1 = Customer.create!(first_name: 'Sally', last_name: 'Shopper')
      customer_4 = Customer.create!(first_name: 'Du', last_name: 'North')
      customer_5 = Customer.create!(first_name: 'Polly', last_name: 'South')
      customer_6 = Customer.create!(first_name: 'Sue', last_name: 'Ann')
      invoice_1 = customer_1.invoices.create!(status: 'completed')
      invoice_2 = customer_2.invoices.create!(status: 'completed')
      invoice_3 = customer_3.invoices.create!(status: 'completed')
      invoice_4 = customer_4.invoices.create!(status: 'completed')
      invoice_5 = customer_5.invoices.create!(status: 'completed')
      invoice_6 = customer_6.invoices.create!(status: 'completed')
      transaction_1 = invoice_1.transactions.create!(credit_card_number: '4111839154983476', credit_card_expiration_date: '11/23', result: 1)
      transaction_2 = invoice_1.transactions.create!(credit_card_number: '4111839154981234', credit_card_expiration_date: '11/24', result: 1)
      transaction_3 = invoice_1.transactions.create!(credit_card_number: '4111839154985673', credit_card_expiration_date: '11/25', result: 1)
      transaction_4 = invoice_1.transactions.create!(credit_card_number: '4111839154989876', credit_card_expiration_date: '11/26', result: 1)
      transaction_5 = invoice_1.transactions.create!(credit_card_number: '4111839154986201', credit_card_expiration_date: '11/27', result: 1)
      transaction_6 = invoice_1.transactions.create!(credit_card_number: '4111839154985551', credit_card_expiration_date: '10/27', result: 1)
      transaction_30 = invoice_1.transactions.create!(credit_card_number: '4111839154983333', credit_card_expiration_date: '09/27', result: 0)
      transaction_7 = invoice_2.transactions.create!(credit_card_number: '4111839154984673', credit_card_expiration_date: '11/28', result: 1)
      transaction_8 = invoice_2.transactions.create!(credit_card_number: '4111839154980980', credit_card_expiration_date: '11/29', result: 1)
      transaction_9 = invoice_2.transactions.create!(credit_card_number: '4111839154983421', credit_card_expiration_date: '11/30', result: 1)
      transaction_10 = invoice_2.transactions.create!(credit_card_number: '4111839154989836', credit_card_expiration_date: '11/31', result: 1)
      transaction_11 = invoice_2.transactions.create!(credit_card_number: '4111839154984365', credit_card_expiration_date: '11/32', result: 1)
      transaction_12 = invoice_3.transactions.create!(credit_card_number: '4111839154987409', credit_card_expiration_date: '11/33', result: 1)
      transaction_13 = invoice_3.transactions.create!(credit_card_number: '4111839154980984', credit_card_expiration_date: '11/34', result: 1)
      transaction_14 = invoice_3.transactions.create!(credit_card_number: '4111839154983721', credit_card_expiration_date: '11/35', result: 1)
      transaction_15 = invoice_3.transactions.create!(credit_card_number: '4111839154987356', credit_card_expiration_date: '11/36', result: 1)
      transaction_16 = invoice_4.transactions.create!(credit_card_number: '4111839154984321', credit_card_expiration_date: '11/37', result: 1)
      transaction_17 = invoice_4.transactions.create!(credit_card_number: '4111839154986543', credit_card_expiration_date: '11/38', result: 1)
      transaction_18 = invoice_4.transactions.create!(credit_card_number: '4111839154988970', credit_card_expiration_date: '11/39', result: 1)
      transaction_19 = invoice_5.transactions.create!(credit_card_number: '4111839154988970', credit_card_expiration_date: '11/40', result: 1)
      transaction_20 = invoice_5.transactions.create!(credit_card_number: '4111839154988970', credit_card_expiration_date: '11/41', result: 1)
      transaction_21 = invoice_6.transactions.create!(credit_card_number: '4111839154984763', credit_card_expiration_date: '11/42', result: 1)

      item_1 = merchant.items.create!(name: 'Gold Ring', description: 'Jewelery', unit_price: 10000)
      item_4 = merchant.items.create!(name: 'Hair Clip', description: 'Accessories', unit_price: 200)
      item_2 = merchant.items.create!(name: 'Silver Ring', description: 'Jewelery', unit_price: 5000)
      item_3 = merchant.items.create!(name: 'Hoop Earrings', description: 'Jewelery', unit_price: 1000)
      item_5 = merchant.items.create!(name: 'Silver Bracelet', description: 'Accessories', unit_price: 3000)
      item_6 = merchant.items.create!(name: 'Bronze Ring', description: 'Jewelery', unit_price: 2000)
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

      visit "/merchants/#{merchant.id}/dashboard"
      save_and_open_page
      expect(page).to have_content(item_1.name)
      expect(page).to have_content(invoice_1.id)
      expect(page).to have_link("Invoice ##{invoice_1.id}")
      expect(item_1.name).to appear_before(item_2.name)
      expect(page).to have_content(item_2.name)
      expect(page).to have_content(invoice_2.id)
      expect(page).to have_link("Invoice ##{invoice_2.id}")
      expect(page).to have_content(item_3.name)
      expect(page).to have_content(invoice_3.id)
      expect(page).to have_link("Invoice ##{invoice_3.id}")
      expect(page).to have_content(item_4.name)
      expect(page).to have_content(invoice_4.id)
      expect(page).to have_link("Invoice ##{invoice_4.id}")
      expect(page).to have_content(item_5.name)
      expect(page).to have_content(invoice_5.id)
      expect(page).to have_link("Invoice ##{invoice_5.id}")
      expect(page).to_not have_content(item_6.name)
      expect(page).to_not have_content(invoice_6.id)
      expect(page).to_not have_link("Invoice ##{invoice_6.id}")
    end
  end
end
