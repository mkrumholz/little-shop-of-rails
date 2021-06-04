require 'rails_helper'

RSpec.describe 'index.html.erb' do
  describe 'visit' do
    before :each do
      @customer_1 = Customer.create!(first_name: 'Madi', last_name: 'Johnson')
      @invoice_1 = @customer_1.invoices.create!(status: 1)
      @invoice_2 = @customer_1.invoices.create!(status: 1)
      @invoice_3 = @customer_1.invoices.create!(status: 1)
      @invoice_4 = @customer_1.invoices.create!(status: 1)
      @invoice_5 = @customer_1.invoices.create!(status: 1)
      @invoice_6 = @customer_1.invoices.create!(status: 1)

      visit 'admin/invoices'
    end
    it 'displays a list of all invoices' do
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_2.id)
      expect(page).to have_content(@invoice_3.id)
      expect(page).to have_content(@invoice_4.id)
      expect(page).to have_content(@invoice_5.id)
      expect(page).to have_content(@invoice_6.id)
    end
    it 'has links to the invoice show pages' do
      expect(page).to have_link("Invoice #{@invoice_1.id}")

      click_link("Invoice #{@invoice_1.id}")

      expect(page).to have_current_path("/admin/invoices/#{@invoice_1.id}")
    end
  end
end
