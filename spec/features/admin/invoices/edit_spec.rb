require 'rails_helper'

    # As an admin
    # When I visit an admin invoice show page
    # I see the invoice status is a select field
    # And I see that the invoice's current status is selected
    # When I click this select field,
    # Then I can select a new status for the Invoice,
    # And next to the select field I see a button to "Update Invoice Status"
    # When I click this button
    # I am taken back to the admin invoice show page
    # And I see that my Invoice's status has now been updated

RSpec.describe 'Admin Invoice Edit' do
  before :each do
    @customer_1 = Customer.create!(first_name: 'Madi', last_name: 'Johnson')
    @invoice_1 = @customer_1.invoices.create!(status: 1, created_at: '2001-01-01')

    visit("/admin/invoices/#{@invoice_1.id}")
  end

  it 'has a selector to update a invoice status with existing value pre-populated' do
    expect(page).to have_selector('#invoice_status', :text => 'completed')
    expect(page).to have_button('Update')
  end

  it 'clicking update redirects to the invoice admin show page, showing updated info' do
    select('cancelled', from: 'invoice_status')
    click_button 'Update'

    expect(page).to have_current_path("/admin/invoices/#{@invoice_1.id}?update=true")

    within("h3#status") do
      expect(page).to have_content("cancelled")
      expect(page).to_not have_content("completed")
    end
  end

  it 'shows a flash message confirming information update' do
    select('cancelled', from: 'invoice_status')
    click_button 'Update'

    expect(page).to have_content("Invoice Successfully Updated")
  end

  # xit 'shows an error if I try to submit an empty name field' do
  #   fill_in 'Name', with: ''
  #   click_button 'Update Merchant'
  #
  #   expect(page).to have_current_path("/admin/merchants/#{@signs.id}/edit")
  #
  #   within(".alert") do
  #     expect(page).to have_content("Error: Name can't be blank")
  #   end
  # end
end
