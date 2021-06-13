require 'rails_helper'

RSpec.describe 'The merchant item show page' do
  before :each do
    allow(GithubService).to receive(:contributors_info).and_return([
                                                                     { id: 26797256, name: 'Molly', contributions: 7 },
                                                                     { id: 78388882, name: 'Sid', contributions: 80 }
                                                                   ])
    allow(GithubService).to receive(:pull_request_info).and_return([
                                                                { id: 0o101010011, name: 'Molly', merged_at: 7 },
                                                                { id: 0o1011230011, name: 'Sid', merged_at: 80 },
                                                                { id: 0o1011230011, name: 'Sid', merged_at: nil }
                                                              ])
    allow(GithubService).to receive(:repo_info).and_return({
                                                             name: 'little-esty-shop'
                                                           })

    @merchant = Merchant.create!(name: 'Little Shop of Horrors')
    @item_1 = @merchant.items.create!(name: 'Audrey II', description: 'Large, man-eating plant', unit_price: '100000000')

    visit "/merchants/#{@merchant.id}/items/#{@item_1.id}"
  end

  it 'displays the item attributes' do
    expect(page).to have_content 'Little Shop of Horrors'
    expect(page).to have_content 'Audrey II'
    expect(page).to have_content 'Large, man-eating plant'
    expect(page).to have_content '$1,000,000.00'
  end

  it 'has a link to update an item' do
    click_on 'Edit item details'

    expect(current_path).to eq "/merchants/#{@merchant.id}/items/#{@item_1.id}/edit"
  end
end
