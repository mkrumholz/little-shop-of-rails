require 'rails_helper'

RSpec.describe 'Admin Invoice Edit' do
  before :each do
    allow(GithubService).to receive(:contributors_info).and_return([
                                                                     { id: 26797256, name: 'Molly', contributions: 7 },
                                                                     { id: 78388882, name: 'Sa', contributions: 80 }
                                                                   ])
    allow(GithubService).to receive(:closed_pulls).and_return([
                                                                { id: 0o101010011, name: 'Molly', merged_at: 7 },
                                                                { id: 0o1011230011, name: 'Sa', merged_at: 80 },
                                                                { id: 0o1011230011, name: 'Sa', merged_at: nil }
                                                              ])
    allow(GithubService).to receive(:repo_info).and_return({
                                                             name: 'little-esty-shop'
                                                           })

    @customer_1 = Customer.create!(first_name: 'Madi', last_name: 'Johnson')
    @invoice_1 = @customer_1.invoices.create!(status: 1, created_at: '2001-01-01')

    visit("/admin/invoices/#{@invoice_1.id}")
  end

  it 'has a selector to update a invoice status with existing value pre-populated' do
    expect(page).to have_select('invoice[status]', selected: 'Completed')
    expect(page).to have_button('Update')
  end

  it 'clicking update redirects to the invoice admin show page, showing updated info' do
    expect(page).to have_select('invoice[status]', selected: 'Completed')

    select 'Cancelled', from: 'invoice[status]'
    click_button 'Update'

    expect(page).to have_current_path("/admin/invoices/#{@invoice_1.id}?update=true")

    expect(page).to have_select('invoice[status]', selected: 'Cancelled')
  end

  it 'shows a flash message confirming information update' do
    select 'Cancelled', from: 'invoice[status]'
    click_button 'Update'

    expect(page).to have_content('Invoice Successfully Updated')
  end
end
