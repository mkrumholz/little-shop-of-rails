require 'rails_helper'

RSpec.describe 'admin header nav' do
  it 'links to the admin dashboard' do
    visit '/admin'

    expect(page).to have_link('Dashboard')
    click_link('Dashboard')

    expect(page).to have_current_path('/admin')
  end

  it 'links to the admin merchants index' do
    visit '/admin'

    expect(page).to have_link('Merchants')
    click_link('Merchants')

    expect(page).to have_current_path('/admin/merchants')
  end
  
  it 'links to the admin invoices index' do
    visit '/admin'

    expect(page).to have_link('Invoices')
    click_link('Invoices')

    expect(page).to have_current_path('/admin/invoices')
  end
end