require 'rails_helper'

  # Invoice id
  # Invoice status
  # Invoice created_at date in the format "Monday, July 18, 2019"
  # Customer first and last name

RSpec.describe 'admin/invoices/show.html.erb' do
  before :each do
    @customer_1 = Customer.create!(first_name: 'Madi', last_name: 'Johnson')
    @invoice_1 = @customer_1.invoices.create!(status: 1, created_at: '2001-01-01')

    visit "/admin/invoices/#{@invoice_1.id}"
  end
  describe 'visit' do
    it 'displays invoice data' do
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content('Monday, January 01, 2001')
    end
  end
end
