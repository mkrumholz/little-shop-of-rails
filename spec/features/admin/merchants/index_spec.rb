require 'rails_helper'

RSpec.describe 'Admin Merchants Index' do
  before :each do
    @signs = Merchant.create!(name: "Sal's Signs", status: true)
    @tees = Merchant.create!(name: "T-shirts by Terry", status: true)
    @amphs = Merchant.create!(name: "All About Amphibians", status: false)

    visit('/admin/merchants')
  end

  it 'shows the names of each merchant in the system' do
    within("#merchant-list") do
      expect(page).to have_content(@signs.name)
      expect(page).to have_content(@tees.name)
      expect(page).to have_content(@amphs.name)
    end
  end

  it 'has a link to the admin merchant show page in each merchant name' do
    within("#merchant-list") do
      expect(page).to have_link("#{@signs.name}", :href=>"/admin/merchants/#{@signs.id}")
      expect(page).to have_link("#{@tees.name}", :href=>"/admin/merchants/#{@tees.id}")
      expect(page).to have_link("#{@amphs.name}", :href=>"/admin/merchants/#{@amphs.id}")
    end
  end

  it 'link directs to show page' do
    click_link("#{@signs.name}")

    expect(page).to have_current_path("/admin/merchants/#{@signs.id}")
  end

  it 'shows the merchant status (enabled or disabled)'
  it 'has a button to enable or disable each merchant'
  it 'on clicking the button, it updates merchant status and returns to the index page'
end
