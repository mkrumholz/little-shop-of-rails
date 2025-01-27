require 'rails_helper'

RSpec.describe 'The merchant item show page' do
  before :each do
    @merchant = create(:merchant_with_items)
    @item_1 = @merchant.items.first

    visit "/merchants/#{@merchant.id}/items/#{@item_1.id}/edit"
  end

  it 'can update the item name' do
    expect(page).to have_content @item_1.name

    fill_in 'item[name]', with: 'The Perfect Crime'
    click_on 'Update item'

    expect(current_path).to eq "/merchants/#{@merchant.id}/items/#{@item_1.id}"
    expect(page).to have_content 'The Perfect Crime'
    expect(page).to have_content 'Victory! 🥳 This item has been successfully updated.'
  end

  it 'can update the item description' do
    expect(page).to have_content @item_1.name

    fill_in 'item[description]', with: "The world\'s best plant"
    click_on 'Update item'

    expect(current_path).to eq "/merchants/#{@merchant.id}/items/#{@item_1.id}"
    expect(page).to have_content "The world\'s best plant"
  end

  it 'can update the item unit_price' do
    expect(page).to have_content @item_1.name

    fill_in 'item[unit_price]', with: 72000.10
    click_on 'Update item'

    expect(current_path).to eq "/merchants/#{@merchant.id}/items/#{@item_1.id}"
    expect(page).to have_content '$72,000.10'
  end

  it 'shows an error message if item is not successfully updated' do
    fill_in 'item[name]', with: nil
    click_on 'Update item'

    expect(current_path).to eq "/merchants/#{@merchant.id}/items/#{@item_1.id}/edit"
    expect(page).to have_content 'Error: Name can\'t be blank'
  end
end
