require 'rails_helper'

RSpec.describe 'Admin Merchant Show' do
  before :each do
    @signs = Merchant.create!(name: "Sal's Signs")

    visit("/admin/merchants/#{@signs.id}")
  end

  it 'Shows the name of the merchant' do
    expect(page).to have_content(@signs.name)
  end

end
