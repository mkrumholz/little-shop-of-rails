require 'rails_helper'

RSpec.describe 'index.html.erb' do
  describe 'visit' do
    it 'displays a dashboard' do
      visit '/admin'

      within('h1#dash') do
        expect(page).to have_content('Admin Dashboard')
      end
    end

    it 'has links to the admin merchants index' do
      visit '/admin'


      expect(page).to have_link('Merchants Index')
      click_link('Merchants Index')

      expect(page).to have_current_path('/admin/merchants')
    end

    it 'has links to the admin invoices index' do
      visit '/admin'

      expect(page).to have_link('Invoices Index')
      click_link('Invoices Index')

      expect(page).to have_current_path('/admin/invoices')
    end

  end
  describe 'Top 5 Customers' do
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
      @invoice_4.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_4.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_4.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_4.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_4.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_6.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_6.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_6.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_6.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_5.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_5.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_5.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_1.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_1.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_3.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      visit '/admin'
    end
    it 'shows the 5 customers with the most successful transactions' do
      expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name}")
      expect(page).to have_content("#{@customer_3.first_name} #{@customer_3.last_name}")
      expect(page).to have_content("#{@customer_4.first_name} #{@customer_4.last_name}")
      expect(page).to have_content("#{@customer_5.first_name} #{@customer_5.last_name}")
      expect(page).to have_content("#{@customer_6.first_name} #{@customer_6.last_name}")
      expect(page).to_not have_content("#{@customer_2.first_name} #{@customer_2.last_name}")
    end
    it 'orders them by completed transactions, last name' do
      expect(@customer_4.first_name).to appear_before(@customer_6.first_name)
      expect(@customer_6.first_name).to appear_before(@customer_5.first_name)
      expect(@customer_5.first_name).to appear_before(@customer_1.first_name)
      expect(@customer_1.first_name).to appear_before(@customer_3.first_name)
    end
    it 'lists the number of completed transactions' do
      expect(page).to have_content('5 transactions')
      expect(page).to have_content('4 transactions')
      expect(page).to have_content('3 transactions')
      expect(page).to have_content('2 transactions')
      expect(page).to have_content('1 transactions')
    end
  end
end
