require 'rails_helper'

RSpec.describe 'admin/invoices/show.html.erb' do
  before :each do
    @merchant_1 = create(:merchant)
    @customer_1 = Customer.create!(first_name: 'Madi', last_name: 'Johnson')

    @invoice_1 = @customer_1.invoices.create!(status: 1, created_at: '2001-01-01')

    @item_1 = @merchant_1.items.create!(name: 'Pogs', description: 'Stack of pogs.', unit_price: 500)
    @item_2 = @merchant_1.items.create!(name: 'Frog statue', description: 'Statue of a frog', unit_price: 10000)
    @item_3 = @merchant_1.items.create!(name: 'Rabid Wolverine', description: 'No refunds', unit_price: 10)
    @item_4 = create(:item, merchant: @merchant_1, unit_price: 1005)

    InvoiceItem.create!(quantity: 50, unit_price: 550, status: 0, item: @item_1, invoice: @invoice_1)
    InvoiceItem.create!(quantity: 3, unit_price: 11500, status: 1, item: @item_2, invoice: @invoice_1)
    InvoiceItem.create!(quantity: 1, unit_price: 16, status: 2, item: @item_3, invoice: @invoice_1)
    InvoiceItem.create!(quantity: 4, unit_price: 1000, status: 2, item: @item_4, invoice: @invoice_1)

    @discount_1 = @merchant_1.discounts.create!(name: '4 or More', percentage: 0.1, quantity_threshold: 4)
    @discount_2 = @merchant_1.discounts.create!(name: '5+ get 15%', percentage: 0.15, quantity_threshold: 5) # should not apply, half dozen is the better discount
    @discount_3 = @merchant_1.discounts.create!(name: 'Half dozen discount', percentage: 0.2, quantity_threshold: 6)

    visit "/admin/invoices/#{@invoice_1.id}"
  end

  describe 'visit' do
    it 'displays invoice data' do
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status.capitalize)
      expect(page).to have_content('Monday, January 01, 2001')
    end

    it 'displays invoices customer name' do
      expect(page).to have_content(@customer_1.first_name)
      expect(page).to have_content(@customer_1.last_name)
    end
  end

  describe 'items on invoice' do
    it 'displays all of the items on the invoice' do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@item_3.name)
      expect(page).to have_content('50')
      expect(page).to have_content('3')
      expect(page).to have_content('1')
      expect(page).to have_content('$5.50')
      expect(page).to have_content('$115.00')
      expect(page).to have_content('$0.16')
    end
  end

  describe 'total revenue' do
    it 'shows the total revenue the invoice will generate (without discounts)' do
      expect(page).to have_content('Total Revenue: $660.16')
    end
  end

  describe 'discounted total revenue' do
    it 'shows the total revenue the invoice will generate with discounts factored in' do
      expect(page).to have_content('Discounted Total: $601.16')
    end
  end
end
