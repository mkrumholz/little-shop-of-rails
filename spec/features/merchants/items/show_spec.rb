require 'rails_helper'

RSpec.describe 'The merchant item show page' do
  before :each do
    @merchant = create(:merchant)
    @item_1 = @merchant.items.create!(name: 'Audrey II', description: 'Large, man-eating plant', unit_price: '100000000')

    visit "/merchants/#{@merchant.id}/items/#{@item_1.id}"
  end

  it 'displays the item attributes' do
    expect(page).to have_content @merchant.name
    expect(page).to have_content @item_1.name
    expect(page).to have_content @item_1.description
    expect(page).to have_content '$1,000,000.00'
  end

  it 'has a link to update an item' do
    click_on 'Edit item details'

    expect(current_path).to eq "/merchants/#{@merchant.id}/items/#{@item_1.id}/edit"
  end
end
