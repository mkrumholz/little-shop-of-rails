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
end
