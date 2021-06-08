require 'rails_helper'

RSpec.describe 'index.html.erb' do
  describe 'visit' do
    before :each do
      allow(GithubService).to receive(:contributors_info).and_return([
        {id: 26797256, name: 'Molly', contributions: 7},
        {id: 78388882, name: 'Sa', contributions: 80}
      ])
      allow(GithubService).to receive(:closed_pulls).and_return([
        {id: 0101010011, name: 'Molly', merged_at: 7},
        {id: 01011230011, name: 'Sa',merged_at: 80},
        {id: 01011230011, name: 'Sa', merged_at: nil}
      ])
      allow(GithubService).to receive(:repo_info).and_return({
          name: 'little-esty-shop'
      })
    end
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
      allow(GithubService).to receive(:contributors_info).and_return([
        {id: 26797256, name: 'Molly', contributions: 7},
        {id: 78388882, name: 'Sa', contributions: 80}
      ])
      allow(GithubService).to receive(:closed_pulls).and_return([
        {id: 0101010011, name: 'Molly', merged_at: 7},
        {id: 01011230011, name: 'Sa',merged_at: 80},
        {id: 01011230011, name: 'Sa', merged_at: nil}
      ])
      allow(GithubService).to receive(:repo_info).and_return({
          name: 'little-esty-shop'
      })
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
  describe 'Incomplete Invoices' do
    before :each do
      allow(GithubService).to receive(:contributors_info).and_return([
        {id: 26797256, name: 'Molly', contributions: 7},
        {id: 78388882, name: 'Sa', contributions: 80}
      ])
      allow(GithubService).to receive(:closed_pulls).and_return([
        {id: 0101010011, name: 'Molly', merged_at: 7},
        {id: 01011230011, name: 'Sa',merged_at: 80},
        {id: 01011230011, name: 'Sa', merged_at: nil}
      ])
      allow(GithubService).to receive(:repo_info).and_return({
          name: 'little-esty-shop'
      })
      @merchant_1 = Merchant.create!(name: "Ralph's Monkey Hut")
      @customer_1 = Customer.create!(first_name: 'Madi', last_name: 'Johnson')
      @customer_2 = Customer.create!(first_name: 'Emmy', last_name: 'Lost')
      @customer_3 = Customer.create!(first_name: 'Shim', last_name: 'Stalone')
      @customer_4 = Customer.create!(first_name: 'Bado', last_name: 'Reason')
      @customer_5 = Customer.create!(first_name: 'Timothy', last_name: 'Richard')
      @customer_6 = Customer.create!(first_name: 'Alex', last_name: '19th')
      @invoice_1 = @customer_1.invoices.create!(status: 1, created_at: '2021-01-25')
      @invoice_2 = @customer_2.invoices.create!(status: 1, created_at: '2020-01-25')
      @invoice_3 = @customer_3.invoices.create!(status: 1, created_at: '2016-01-25')
      @invoice_4 = @customer_4.invoices.create!(status: 1, created_at: '2001-01-25')
      @invoice_5 = @customer_5.invoices.create!(status: 1, created_at: '2004-01-25')
      @invoice_6 = @customer_6.invoices.create!(status: 1, created_at: '2011-01-25')
      @item_1 = @merchant_1.items.create!(name: 'Pogs', description: 'Stack of pogs.', unit_price: 500,)
      InvoiceItem.create!(quantity: 1, unit_price: 550, status: 0, item: @item_1, invoice: @invoice_1)
      InvoiceItem.create!(quantity: 2, unit_price: 550, status: 2, item: @item_1, invoice: @invoice_1)
      InvoiceItem.create!(quantity: 1, unit_price: 550, status: 0, item: @item_1, invoice: @invoice_2)
      InvoiceItem.create!(quantity: 1, unit_price: 550, status: 0, item: @item_1, invoice: @invoice_3)
      InvoiceItem.create!(quantity: 1, unit_price: 550, status: 0, item: @item_1, invoice: @invoice_4)
      InvoiceItem.create!(quantity: 2, unit_price: 550, status: 2, item: @item_1, invoice: @invoice_5)
      InvoiceItem.create!(quantity: 2, unit_price: 550, status: 2, item: @item_1, invoice: @invoice_6)
      InvoiceItem.create!(quantity: 1, unit_price: 550, status: 0, item: @item_1, invoice: @invoice_6)
      visit '/admin'
    end
    it 'displays a list of all invoices with unshipped items' do
      expect(page).to have_content("Incomplete Invoices")
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_2.id)
      expect(page).to have_content(@invoice_3.id)
      expect(page).to have_content(@invoice_4.id)
      expect(page).to have_content(@invoice_6.id)
      expect(page).to_not have_content(@invoice_5.id)
    end
    it 'links the ids to their admin show page' do
      expect(page).to have_link("Invoice #{@invoice_1.id}")
      expect(page).to have_link("Invoice #{@invoice_2.id}")
      expect(page).to have_link("Invoice #{@invoice_3.id}")
      expect(page).to have_link("Invoice #{@invoice_4.id}")
      expect(page).to have_link("Invoice #{@invoice_6.id}")

      click_link("Invoice #{@invoice_1.id}")

      expect(page).to have_current_path("/admin/invoices/#{@invoice_1.id}")
    end

    it 'displays the date each invoice was created' do
      expect(page).to have_content('Tuesday, January 25, 2011')
      expect(page).to have_content('Monday, January 25, 2016')
      expect(page).to have_content('Thursday, January 25, 2001')
      expect(page).to have_content('Monday, January 25, 2021')
      expect(page).to have_content('Saturday, January 25, 2020')
    end
    it 'displays the invoices in order created from oldest to newest' do
      expect("#{@invoice_4.id}").to appear_before("#{@invoice_6.id}")
      expect("#{@invoice_6.id}").to appear_before("#{@invoice_3.id}")
      expect("#{@invoice_3.id}").to appear_before("#{@invoice_2.id}")
      expect("#{@invoice_2.id}").to appear_before("#{@invoice_1.id}")
    end
  end
end
