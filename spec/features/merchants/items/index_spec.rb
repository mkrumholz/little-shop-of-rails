require 'rails_helper'

RSpec.describe 'The merchant items index' do
  before :each do
    @merchant = Merchant.create!(name: "Little Shop of Horrors")
    @customer = Customer.create!(first_name: 'Audrey', last_name: 'I')

    @item_1 = @merchant.items.create!(name: 'Audrey II', description: 'Large, man-eating plant', unit_price: '100000000', enabled: true)
    @item_2 = @merchant.items.create!(name: 'Bouquet of roses', description: '12 red roses', unit_price: '1900', enabled: true)
    @item_3 = @merchant.items.create!(name: 'Orchid', description: 'Purple, 3 inches', unit_price: '2700', enabled: false)
    @item_4 = @merchant.items.create!(name: 'Echevaria', description: 'Peacock varietal', unit_price: '3100', enabled: true)
    @item_5 = @merchant.items.create!(name: 'Fourth item', description: '4th best', unit_price: '26400', enabled: true)
    @item_6 = @merchant.items.create!(name: 'Fifth item', description: '5th best', unit_price: '2400', enabled: true)
    @item_7 = @merchant.items.create!(name: 'Sixth item', description: '6th best', unit_price: '50', enabled: true)

    @invoice_1 = @customer.invoices.create!(status: 1) # is successful and paid
    @invoice_2 = @customer.invoices.create!(status: 0) # is cancelled
    @invoice_3 = @customer.invoices.create!(status: 2) # is still in progress, no good transactions
    @invoice_4 = @customer.invoices.create!(status: 1) # is successful and paid
    @invoice_5 = @customer.invoices.create!(status: 1) # has no successful transaction

    @invoice_item_1 = @item_1.invoice_items.create!(invoice_id: @invoice_1.id, quantity: 2, unit_price: 5000, status: 0)
    @invoice_item_2 = @item_2.invoice_items.create!(invoice_id: @invoice_1.id, quantity: 2, unit_price: 2500, status: 0)
    @invoice_item_3 = @item_4.invoice_items.create!(invoice_id: @invoice_1.id, quantity: 2, unit_price: 1000, status: 0)
    @invoice_item_4 = @item_1.invoice_items.create!(invoice_id: @invoice_2.id, quantity: 2, unit_price: 5000, status: 0)
    @invoice_item_5 = @item_1.invoice_items.create!(invoice_id: @invoice_3.id, quantity: 2, unit_price: 5000, status: 0)
    @invoice_item_6 = @item_5.invoice_items.create!(invoice_id: @invoice_4.id, quantity: 2, unit_price: 500, status: 0)
    @invoice_item_7 = @item_6.invoice_items.create!(invoice_id: @invoice_4.id, quantity: 2, unit_price: 200, status: 0)
    @invoice_item_8 = @item_7.invoice_items.create!(invoice_id: @invoice_4.id, quantity: 2, unit_price: 50, status: 0)

    @invoice_1.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
    @invoice_2.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
    @invoice_4.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
    @invoice_5.transactions.create!(result: 0, credit_card_number: '534', credit_card_expiration_date: 'null')
  end

  it 'lists all of the items' do
    visit "/merchants/#{@merchant.id}/items"

    expect(page).to have_content 'Audrey II'
    expect(page).to have_content 'Bouquet of roses'
    expect(page).to have_content 'Orchid'
    expect(page).to have_content 'Echevaria'
  end

  it 'links to each item show page' do
    visit "/merchants/#{@merchant.id}/items"
    visit "/merchants/#{@merchant.id}/items"
    
    within "section#enabled" do
      click_on 'Audrey II' 
    end

    expect(current_path).to eq "/merchants/#{@merchant.id}/items/#{@item_1.id}"
    expect(page).to have_content 'Audrey II'
  end

  it 'groups items by status' do
    visit "/merchants/#{@merchant.id}/items"

    within "section#enabled" do
      expect(page).to have_content 'Enabled Items'
      expect(page).to have_content 'Audrey II'
      expect(page).to have_content 'Bouquet of roses'
      expect(page).to have_content 'Echevaria'
      expect(page).to have_button 'Disable'
      expect(page).to_not have_button 'Enable'
      expect(page).to_not have_content 'Orchid'
    end

    within "section#disabled" do
      expect(page).to have_content 'Disabled Items'
      expect(page).to have_content 'Orchid'
      expect(page).to have_button 'Enable'
      expect(page).to_not have_button 'Disable'
      expect(page).to_not have_content 'Audrey II'
    end
  end

  it 'can enable a disabled item' do
    visit "/merchants/#{@merchant.id}/items"
    
    within "section#enabled" do
      within "div#item-#{@item_2.id}" do
        click_on 'Disable'
      end
    end

    expect(current_path).to eq "/merchants/#{@merchant.id}/items"

    within "section#enabled" do
      expect(page).to_not have_content 'Bouquet of roses'
    end

    within "section#disabled" do
      expect(page).to have_content 'Bouquet of roses'
    end
  end

  it 'can disable an enabled item' do
    visit "/merchants/#{@merchant.id}/items"
    
    within "section#disabled" do
      within "div#item-#{@item_3.id}" do
        click_on 'Enable'
      end
    end

    expect(current_path).to eq "/merchants/#{@merchant.id}/items"

    within "section#enabled" do
      expect(page).to have_content 'Orchid'
    end

    within "section#disabled" do
      expect(page).to_not have_content 'Orchid'
    end
  end

  it 'lists the top 5 best-selling items by revenue generated' do
    visit "/merchants/#{@merchant.id}/items"

    within "section#popular" do  
      expect(@item_1.name).to appear_before @item_2.name
      expect(@item_2.name).to appear_before @item_4.name
      expect(@item_4.name).to appear_before @item_5.name
      expect(@item_5.name).to appear_before @item_6.name
      expect(page).to_not have_content @item_3.name
      expect(page).to_not have_content @item_7.name
    end 
  end

  it 'links to each merchant item show page from popular items' do
    visit "/merchants/#{@merchant.id}/items"

    within "section#popular" do 
      expect(page).to have_link 'Audrey II'
    end
  end

  it 'displays the total revenue generated for each popular item' do
    visit "/merchants/#{@merchant.id}/items"

    within "section#popular" do 
      expect(page).to have_content 'Total revenue: 10000'
      expect(page).to have_content 'Total revenue: 5000'
      expect(page).to have_content 'Total revenue: 2000'
      expect(page).to have_content 'Total revenue: 400'
      expect(page).to have_content 'Total revenue: 100'
    end
  end
end

# Merchant Items Index: 5 most popular items

# As a merchant
# When I visit my items index page
# Then I see the names of the top 5 most popular items ranked by total revenue generated
# And I see that each item name links to my merchant item show page for that item
# And I see the total revenue generated next to each item name

# Notes on Revenue Calculation:
# - Only invoices with at least one successful transaction should count towards revenue
# - Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
# - Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)