# As a merchant
# When I visit my items index page
# I see a link to create a new item.
# When I click on the link,
# I am taken to a form that allows me to add item information.
# When I fill out the form I click ‘Submit’
# Then I am taken back to the items index page
# And I see the item I just created displayed in the list of items.
# And I see my item was created with a default status of disabled.

require 'rails_helper'

RSpec.describe 'Merchant item create page' do
  before :each do
    @merchant = Merchant.create!(name: "Little Shop of Horrors")
  end

  it 'can create a new item as enabled' do
    visit "/merchants/#{@merchant.id}/items/new"

    fill_in :name, with: 'Audrey II'
    fill_in :description, with: 'Large, man-eating plant'
    fill_in :unit_price, with: '12345.67'
    check :enabled
    click_button 'Create Item'

    expect(current_path).to eq "/merchants/#{@merchant.id}/items/"
    within 'div#enabled' do
      expect(page).to have_link 'Audrey II'
    end
  end

  it 'defaults enabled to false' do
    visit "/merchants/#{@merchant.id}/items/new"

    fill_in :name, with: 'Audrey II'
    fill_in :description, with: 'Large, man-eating plant'
    fill_in :unit_price, with: '12345.67'
    click_button 'Create Item'

    expect(current_path).to eq "/merchants/#{@merchant.id}/items/"
    within 'div#disabled' do
      expect(page).to have_link 'Audrey II'
    end
  end
end