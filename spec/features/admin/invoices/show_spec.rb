require 'rails_helper'

  # Invoice id
  # Invoice status
  # Invoice created_at date in the format "Monday, July 18, 2019"
  # Customer first and last name

RSpec.describe 'admin/invoices/show.html.erb' do
  before :each do
    @customer_1 = Customer.create!(first_name: 'Madi', last_name: 'Johnson')
    @invoice_1 = @customer_1.invoices.create!(status: 1, created_at: '2001-01-01')
    @merchant_1 = Merchant.create!(name: "Ralph's Monkey Hut")
    @item_1 = @merchant_1.items.create!(name: 'Pogs', description: 'Stack of pogs.', unit_price: 500,)
    @item_2 = @merchant_1.items.create!(name: 'Frog statue', description: 'Statue of a frog', unit_price: 10000,)
    @item_3 = @merchant_1.items.create!(name: 'Rapid Woliverine', description: 'No refunds', unit_price: 10,)
    InvoiceItem.create!(quantity: 50, unit_price: 550, status: 0, item: @item_1, invoice: @invoice_1)
    InvoiceItem.create!(quantity: 3, unit_price: 11500, status: 1, item: @item_2, invoice: @invoice_1)
    InvoiceItem.create!(quantity: 1, unit_price: 16, status: 2, item: @item_3, invoice: @invoice_1)

    visit "/admin/invoices/#{@invoice_1.id}"
  end
  describe 'visit' do
    it 'displays invoice data' do
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content('Monday, January 01, 2001')
    end
    it 'displays invoices customer name' do
      expect(page).to have_content(@customer_1.first_name)
      expect(page).to have_content(@customer_1.last_name)
    end
  end
  describe 'items on invoice' do
    it 'dislplays all of the items on the invoice' do
      # Item name
      # The quantity of the item ordered
      # The price the Item sold for
      # The Invoice Item status
      save_and_open_page

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@item_3.name)
      expect(page).to have_content(@item_1.quantity)
      expect(page).to have_content(@item_2.quantity)
      expect(page).to have_content(@item_3.quantity)
      expect(page).to have_content('$5.50')
      expect(page).to have_content('$115.00')
      expect(page).to have_content('$0.16')
    end
  end
end
