require 'rails_helper'

RSpec.describe 'Admin Merchant Show' do
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
    @signs = Merchant.create!(name: "Sal's Signs", status: true)

    visit("/admin/merchants/#{@signs.id}")
  end

  it 'Shows the name of the merchant' do
    expect(page).to have_content(@signs.name)
  end

  it 'has a link to update merchant information' do
    expect(page).to have_button('Update Merchant')

    click_button('Update Merchant')

    expect(page).to have_current_path("/admin/merchants/#{@signs.id}/edit")
  end
end
