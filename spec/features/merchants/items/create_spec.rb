require 'rails_helper'

RSpec.describe 'Merchant item create page' do
  before :each do
    allow(GithubService).to receive(:contributors_info).and_return([
      {id: 26797256, name: 'Molly', contributions: 7},
      {id: 78388882, name: 'Sa', contributions: 80}
    ])
    allow(GithubService).to receive(:closed_pulls).and_return([
      {id: 0101010011, name: 'Molly', merged_at: 7},
      {id: 01011230011, name: 'Sa',merged_at: 80},
      {id: 01011230011, name: 'Sa', merged_at: nil}
    ])
    allow(GithubService).to receive(:repo_info).and_return({
        name: 'little-esty-shop'
    })

    @merchant = FactoryBot.create(:merchant)
    
    visit "/merchants/#{@merchant.id}/items/new"
  end

  it 'can create a new item as enabled' do

    fill_in 'item[name]', with: 'Audrey II'
    fill_in 'item[description]', with: 'Large, man-eating plant'
    fill_in 'item[unit_price]', with: '12345.67'
    check 'item[enabled]'
    click_button 'Create Item'

    expect(current_path).to eq "/merchants/#{@merchant.id}/items"
    within "section#enabled" do
      expect(page).to have_link 'Audrey II'
    end
  end

  it 'defaults enabled to false' do

    fill_in 'item[name]', with: 'Audrey II'
    fill_in 'item[description]', with: 'Large, man-eating plant'
    fill_in 'item[unit_price]', with: '12345.67'
    click_button 'Create Item'

    expect(current_path).to eq "/merchants/#{@merchant.id}/items"
    within "section#disabled" do
      expect(page).to have_link 'Audrey II'
    end
  end

  it 'throws an error if fields are not completed' do

    fill_in 'item[description]', with: 'Large, man-eating plant'
    click_button 'Create Item'

    expect(current_path).to eq "/merchants/#{@merchant.id}/items/new"
    expect(page).to have_content "Name can\'t be blank"
  end
end
