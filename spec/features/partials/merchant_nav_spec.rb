require 'rails_helper'

RSpec.describe 'admin header nav' do
  before :each do
    @merchant = FactoryBot.create(:merchant)
  end

  it 'links to the admin dashboard' do
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_link('Dashboard')
    click_link('Dashboard')

    expect(page).to have_current_path("/merchants/#{@merchant.id}/dashboard")
  end

  it 'links to the admin merchants index' do
  visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_link('My Items')
    click_link('My Items')

    expect(page).to have_current_path("/merchants/#{@merchant.id}/items")
  end
  
  it 'links to the admin invoices index' do
  visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_link('My Invoices')
    click_link('My Invoices')

    expect(page).to have_current_path("/merchants/#{@merchant.id}/invoices")
  end
end