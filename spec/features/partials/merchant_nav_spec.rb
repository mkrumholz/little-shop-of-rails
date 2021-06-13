require 'rails_helper'

RSpec.describe 'merchant header nav' do
  before :each do
    allow(GithubService).to receive(:contributors_info).and_return([
                                                                     { id: 26797256, name: 'Molly', contributions: 7 },
                                                                     { id: 78388882, name: 'Sa', contributions: 80 }
                                                                   ])
    allow(GithubService).to receive(:pull_request_info).and_return([
                                                                { id: 0o101010011, name: 'Molly', merged_at: 7 },
                                                                { id: 0o1011230011, name: 'Sa', merged_at: 80 },
                                                                { id: 0o1011230011, name: 'Sa', merged_at: nil }
                                                              ])
    allow(GithubService).to receive(:repo_info).and_return({
                                                             name: 'little-esty-shop'
                                                           })

    @merchant = FactoryBot.create(:merchant)

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
