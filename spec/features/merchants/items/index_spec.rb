require 'rails_helper'

RSpec.describe 'The merchant items index' do
  it 'lists all of the items' do
    merchant = Merchant.create!(name: "Susan")
    item = merchant.items.create!(name: 'glass', description: 'clear', unit_price: '1400')
    visit "/merchants/#{merchant.id}/items"

    expect(page).to have_content item.name
  end
end