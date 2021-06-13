require 'rails_helper'

RSpec.describe 'Admin Merchants Index' do
  before :each do
    @signs = Merchant.create!(name: "Sal's Signs", status: true)
    @tees = Merchant.create!(name: 'T-shirts by Terry', status: true)
    @amphs = Merchant.create!(name: 'All About Amphibians', status: false)

    @merch_1 = Merchant.create!(name: 'Merchant 1', status: true)
    @merch_2 = Merchant.create!(name: 'Merchant 2', status: true)
    @merch_3 = Merchant.create!(name: 'Merchant 3', status: false)
    @merch_4 = Merchant.create!(name: 'Merchant 4', status: true)
    @merch_5 = Merchant.create!(name: 'Merchant 5', status: true)
    @merch_6 = Merchant.create!(name: 'Merchant 6', status: false)

    @item_1 = @merch_1.items.create!(name: 'thing1', description: 'thing1 is a thing', unit_price: 10)
    @item_2 = @merch_1.items.create!(name: 'thing2', description: 'thing1 is a thing', unit_price: 10)
    @item_3 = @merch_2.items.create!(name: 'thing1', description: 'thing1 is a thing', unit_price: 1)
    @item_4 = @merch_2.items.create!(name: 'thing2', description: 'thing2 is a thing', unit_price: 1)
    @item_5 = @merch_3.items.create!(name: 'thing1', description: 'thing1 is a thing', unit_price: 10)
    @item_6 = @merch_3.items.create!(name: 'thing2', description: 'thing2 is a thing', unit_price: 10)
    @item_7 = @merch_4.items.create!(name: 'thing1', description: 'thing1 is a thing', unit_price: 10)
    @item_8 = @merch_4.items.create!(name: 'thing2', description: 'thing2 is a thing', unit_price: 10)
    @item_9 = @merch_5.items.create!(name: 'thing1', description: 'thing1 is a thing', unit_price: 10)
    @item_10 = @merch_5.items.create!(name: 'thing2', description: 'thing2 is a thing', unit_price: 10)
    @item_11 = @merch_6.items.create!(name: 'thing1', description: 'thing1 is a thing', unit_price: 10)
    @item_12 = @merch_6.items.create!(name: 'thing2', description: 'thing2 is a thing', unit_price: 10)

    @customer = Customer.create!(first_name: 'Sam', last_name: 'Shmo')

    @invoice_1 = @customer.invoices.create!(status: 1, created_at: '15/01/2020')
    @invoice_2 = @customer.invoices.create!(status: 1)

    @transaction_1 = @invoice_1.transactions.create!(credit_card_number: '123123123', credit_card_expiration_date: '', result: 1)
    @transaction_2 = @invoice_1.transactions.create!(credit_card_number: '123123123', credit_card_expiration_date: '', result: 0)
    @transaction_3 = @invoice_2.transactions.create!(credit_card_number: '123123123', credit_card_expiration_date: '', result: 0)
    @transaction_4 = @invoice_2.transactions.create!(credit_card_number: '123123123', credit_card_expiration_date: '', result: 0)

    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 10, unit_price: 100, status: 2)
    @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 10, unit_price: 100, status: 2)
    @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_1.id, quantity: 2, unit_price: 10, status: 2)
    @invoice_item_4 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_2.id, quantity: 2, unit_price: 10, status: 2)
    @invoice_item_5 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_1.id, quantity: 15, unit_price: 100, status: 2)
    @invoice_item_6 = InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_2.id, quantity: 15, unit_price: 100, status: 2)
    @invoice_item_7 = InvoiceItem.create!(item_id: @item_7.id, invoice_id: @invoice_1.id, quantity: 2, unit_price: 100, status: 2)
    @invoice_item_8 = InvoiceItem.create!(item_id: @item_8.id, invoice_id: @invoice_2.id, quantity: 2, unit_price: 100, status: 2)
    @invoice_item_9 = InvoiceItem.create!(item_id: @item_9.id, invoice_id: @invoice_1.id, quantity: 20, unit_price: 100, status: 2)
    @invoice_item_10 = InvoiceItem.create!(item_id: @item_10.id, invoice_id: @invoice_2.id, quantity: 20, unit_price: 100, status: 2)
    @invoice_item_11 = InvoiceItem.create!(item_id: @item_11.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 100, status: 2)
    @invoice_item_12 = InvoiceItem.create!(item_id: @item_12.id, invoice_id: @invoice_2.id, quantity: 5, unit_price: 100, status: 2)

    visit('/admin/merchants')
  end

  it 'shows the names of each merchant in the system' do
    within('#merchant-list') do
      expect(page).to have_content(@signs.name)
      expect(page).to have_content(@tees.name)
      expect(page).to have_content(@amphs.name)
    end
  end

  it 'has a link to the admin merchant show page in each merchant name' do
    within('#merchant-list') do
      expect(page).to have_link(@signs.name.to_s, :href => "/admin/merchants/#{@signs.id}")
      expect(page).to have_link(@tees.name.to_s, :href => "/admin/merchants/#{@tees.id}")
      expect(page).to have_link(@amphs.name.to_s, :href => "/admin/merchants/#{@amphs.id}")
    end
  end

  it 'link directs to show page' do
    within('#merchant-list') do
      click_link(@signs.name.to_s)

      expect(page).to have_current_path("/admin/merchants/#{@signs.id}")
    end
  end

  it 'has a button to enable or disable each merchant' do
    within("#merchant-#{@signs.id}") do
      expect(page).to have_button('Disable')
      expect(page).to_not have_button('Enable')
    end
    within("#merchant-#{@tees.id}") do
      expect(page).to have_button('Disable')
      expect(page).to_not have_button('Enable')
    end
    within("#merchant-#{@amphs.id}") do
      expect(page).to have_button('Enable')
      expect(page).to_not have_button('Disable')
    end
  end

  it 'on clicking the button, it updates merchant status and returns to the index page' do
    within("#merchant-#{@signs.id}") do
      click_button 'Disable'
      expect(page).to have_current_path('/admin/merchants')
      expect(page).to have_button('Enable')
      expect(page).to_not have_button('Disable')
    end
    within("#merchant-#{@tees.id}") do
      click_button 'Disable'
      expect(page).to have_current_path('/admin/merchants')
      expect(page).to have_button('Enable')
      expect(page).to_not have_button('Disable')
    end
    within("#merchant-#{@amphs.id}") do
      click_button 'Enable'
      expect(page).to have_current_path('/admin/merchants')
      expect(page).to have_button('Disable')
      expect(page).to_not have_button('Enable')
    end
  end

  it 'shows merchants in sections based on status' do
    within('#enabled') do
      expect(page).to have_content('Enabled Merchants')
      expect(page).to have_content(@signs.name)
      expect(page).to have_content(@tees.name)
      expect(page).to_not have_content(@amphs.name)
    end
    within('#disabled') do
      expect(page).to have_content('Disabled Merchants')
      expect(page).to_not have_content(@signs.name)
      expect(page).to_not have_content(@tees.name)
      expect(page).to have_content(@amphs.name)
    end
  end

  it 'shows a link to create a new merchant that redirects to a create form' do
    expect(page).to have_link('New Merchant', :href => '/admin/merchants/new')

    click_link('New Merchant')
    expect(page).to have_current_path('/admin/merchants/new')
  end

  it 'shows a Top Merchants section' do
    expect(page).to have_content('Top Merchants')
  end

  it 'top 5 merchants by revenue shows the top 5 merchants by total revenue, total revenue, and links to show page' do
    within('#top-5') do
      expect(page).to have_content(@merch_5.name)
      expect(page).to have_link(@merch_5.name, :href => "/admin/merchants/#{@merch_5.id}")
      expect(page).to have_content(@merch_3.name)
      expect(page).to have_link(@merch_3.name, :href => "/admin/merchants/#{@merch_3.id}")
      expect(page).to have_content(@merch_1.name)
      expect(page).to have_link(@merch_1.name, :href => "/admin/merchants/#{@merch_1.id}")
      expect(page).to have_content(@merch_6.name)
      expect(page).to have_link(@merch_6.name, :href => "/admin/merchants/#{@merch_6.id}")
      expect(page).to have_content(@merch_4.name)
      expect(page).to have_link(@merch_4.name, :href => "/admin/merchants/#{@merch_4.id}")

      expect(page).to have_content('$20.00')
      expect(page).to have_content('$15.00')
      expect(page).to have_content('$10.00')
      expect(page).to have_content('$5.00')
      expect(page).to have_content('$2.00')
    end
  end

  it 'shows the top selling date for each of the 5 merchants based on the invoice date' do
    within('#top-5') do
      expect(page).to have_content("Top selling date for #{@merch_5.name} was 01/15/20")
      expect(page).to have_content("Top selling date for #{@merch_3.name} was 01/15/20")
      expect(page).to have_content("Top selling date for #{@merch_1.name} was 01/15/20")
      expect(page).to have_content("Top selling date for #{@merch_6.name} was 01/15/20")
      expect(page).to have_content("Top selling date for #{@merch_4.name} was 01/15/20")
    end
  end
end
