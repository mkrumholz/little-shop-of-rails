require 'rails_helper'

RSpec.describe 'Admin Merchant Show' do
  before :each do
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
