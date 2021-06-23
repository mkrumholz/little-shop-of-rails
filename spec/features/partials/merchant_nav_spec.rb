require 'rails_helper'

RSpec.describe 'merchant header nav' do
  before :each do
    @merchant = create(:merchant)

    visit "/merchants/#{@merchant.id}/dashboard"
  end

  it 'links to the merchant dashboard' do
    expect(page).to have_link('Dashboard')
    click_link('Dashboard')

    expect(page).to have_current_path("/merchants/#{@merchant.id}/dashboard")
  end

  it 'links to the merchant items index' do
    expect(page).to have_link('My Items')
    click_link('My Items')

    expect(page).to have_current_path("/merchants/#{@merchant.id}/items")
  end

  it 'links to the merchant invoices index' do
    expect(page).to have_link('My Invoices')
    click_link('My Invoices')

    expect(page).to have_current_path("/merchants/#{@merchant.id}/invoices")
  end
end
