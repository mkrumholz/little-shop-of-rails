require 'rails_helper'

RSpec.describe 'The merchant items index' do
  before :each do
    @merchant = Merchant.create!(name: "Little Shop of Horrors")
    @item_1 = @merchant.items.create!(name: 'Audrey II', description: 'Large, man-eating plant', unit_price: '100000000', enabled: true)
    @item_2 = @merchant.items.create!(name: 'Bouquet of roses', description: '12 red roses', unit_price: '1900', enabled: true)
    @item_3 = @merchant.items.create!(name: 'Orchid', description: 'Purple, 3 inches', unit_price: '2700', enabled: false)
    @item_4 = @merchant.items.create!(name: 'Echivaria', description: 'Peacock varietal', unit_price: '3100', enabled: true)
  end

  it 'lists all of the items' do
    visit "/merchants/#{@merchant.id}/items"

    expect(page).to have_content 'Audrey II'
    expect(page).to have_content 'Bouquet of roses'
    expect(page).to have_content 'Orchid'
    expect(page).to have_content 'Echivaria'
  end

  it 'links to each item show page' do
    visit "/merchants/#{@merchant.id}/items"
    visit "/merchants/#{@merchant.id}/items"
    
    click_on 'Audrey II' 

    expect(current_path).to eq "/merchants/#{@merchant.id}/items/#{@item_1.id}"
    expect(page).to have_content 'Audrey II'
  end

  it 'groups items by status' do
    visit "/merchants/#{@merchant.id}/items"

    within "div#enabled_items" do
      expect(page).to have_content 'Enabled Items'
      expect(page).to have_content 'Audrey II'
      expect(page).to have_content 'Bouquet of roses'
      expect(page).to have_content 'Echevaria'
      expect(page).to have_button 'Disable'
      expect(page).to_not have_button 'Enable'
      expect(page).to_not have_content 'Orchid'
    end

    within "div#disabled_items" do
      expect(page).to have_content 'Disabled Items'
      expect(page).to have_content 'Orchid'
      expect(page).to have_button 'Enable'
      expect(page).to_not have_button 'Disable'
      expect(page).to_not have_content 'Audrey II'
    end
  end

  it 'can enable a disabled item'

  it 'can disable an enabled item'
end