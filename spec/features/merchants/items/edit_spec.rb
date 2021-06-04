require 'rails_helper'

RSpec.describe 'The merchant item show page' do
  before :each do
    @merchant = Merchant.create!(name: "Little Shop of Horrors")
    @item_1 = @merchant.items.create!(name: 'Audrey II', description: 'Large, man-eating plant', unit_price: '100000000')
  end

  it 'can update the item name' do
    visit "/merchants/#{@merchant.id}/items/#{@item_1.id}/edit"

    expect(page).to have_content @item_1.name
    
    fill_in 'item[name]', with: 'The Perfect Crime'
    click_on 'Update item'

    expect(current_path).to eq "/merchants/#{@merchant.id}/items/#{@item_1.id}"
    expect(page).to have_content 'The Perfect Crime'
  end

  it 'can update the item description' do
    visit "/merchants/#{@merchant.id}/items/#{@item_1.id}/edit"

    expect(page).to have_content @item_1.name
    
    fill_in 'item[description]', with: "The world\'s best plant"
    click_on 'Update item'

    expect(current_path).to eq "/merchants/#{@merchant.id}/items/#{@item_1.id}"
    expect(page).to have_content "The world\'s best plant"
  end 

  it 'can update the item unit_price' do
    visit "/merchants/#{@merchant.id}/items/#{@item_1.id}/edit"

    expect(page).to have_content @item_1.name
    
    fill_in 'item[unit_price]', with: 7200000
    click_on 'Update item'

    expect(current_path).to eq "/merchants/#{@merchant.id}/items/#{@item_1.id}"
    expect(page).to have_content '$72000.00'
  end

  it 'shows an error message if item is not successfully updated' do
    visit "/merchants/#{@merchant.id}/items/#{@item_1.id}/edit"

    fill_in 'item[name]', with: nil
    click_on 'Update item'

    expect(current_path).to eq "/merchants/#{@merchant.id}/items/#{@item_1.id}/edit"
    expect(page).to have_content 'Some error message'
  end
end