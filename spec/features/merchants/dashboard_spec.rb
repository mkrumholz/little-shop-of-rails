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
      customer_1 = Customer.create!(first_name: 'Sally', last_name: 'Shopper')
      customer_2 = Customer.create!(first_name: 'Evan', last_name: 'East')
      customer_3 = Customer.create!(first_name: 'Yasha', last_name: 'West')
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
      save_and_open_page
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
  end
end
