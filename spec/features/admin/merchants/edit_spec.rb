require 'rails_helper'

RSpec.describe 'Admin Merchant Edit' do
  before :each do
    @signs = Merchant.create!(name: "Sal's Signs")

    visit("/admin/merchants/#{@signs.id}/edit")
  end

  it 'has a form to update a merchant with existing values pre-populated' do
    expect(page).to have_field('name', :with => @signs.name)
  end

  it 'submitting form redirects to the merchant admin show page, showing updated info' do
    fill_in 'name', with: "Salvadore's Signage"
    click_button "Update Merchant"

    expect(page).to have_current_path("/admin/merchants/#{@signs.id}")
    within("h1") do
      expect(page).to have_content("Salvadore's Signage")
      expect(page).to_not have_content("Sal's Signs")
    end
  end

  it 'shows a flash message confirming information update' do
    fill_in 'name', with: "Salvadore's Signage"
    click_button "Update Merchant"

    expect(page).to have_current_path("/admin/merchants/#{@signs.id}")
    within(".confirm") do
      expect(page).to have_content("Merchant Successfully Updated")
    end
  end
end
