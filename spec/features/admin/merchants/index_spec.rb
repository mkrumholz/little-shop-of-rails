require 'rails_helper'

RSpec.describe 'Admin Merchants Index' do
  before :each do
    @signs = Merchant.create!(name: "Sal's Signs")
    @tees = Merchant.create!(name: "T-shirts by Terry")
    @amphs = Merchant.create!(name: "All About Amphibians")

    visit('/admin/merchants')
  end

  it 'shows the names of each merchant in the system' do
    expect(page).to have_content(@signs.name)
    expect(page).to have_content(@tees.name)
    expect(page).to have_content(@amphs.name)
  end

  it 'links to the admin merchant show page in each merchant name' do
    save_and_open_page
    expect(page).to have_link("#{@signs.name}", :href=>"/admin/merchants/#{@signs.id}")
    expect(page).to have_link("#{@tees.name}", :href=>"/admin/merchants/#{@tees.id}")
    expect(page).to have_link("#{@amphs.name}", :href=>"/admin/merchants/#{@amphs.id}")
  end
end
