require 'rails_helper'

RSpec.describe 'Admin Merchant Edit' do
  before :each do
    allow(GithubService).to receive(:contributors_info).and_return([
                                                                     { id: 26797256, name: 'Molly', contributions: 7 },
                                                                     { id: 78388882, name: 'Sa', contributions: 80 }
                                                                   ])
    allow(GithubService).to receive(:pull_request_info).and_return([
                                                                { id: 0o101010011, name: 'Molly', merged_at: 7 },
                                                                { id: 0o1011230011, name: 'Sa', merged_at: 80 },
                                                                { id: 0o1011230011, name: 'Sa', merged_at: nil }
                                                              ])
    allow(GithubService).to receive(:repo_info).and_return({
                                                             name: 'little-esty-shop'
                                                           })
    @signs = Merchant.create!(name: "Sal's Signs", status: true)

    visit("/admin/merchants/#{@signs.id}/edit")
  end

  it 'has a form to update a merchant with existing values pre-populated' do
    expect(page).to have_field('Name', :with => @signs.name)
  end

  it 'submitting form redirects to the merchant admin show page, showing updated info' do
    fill_in 'Name', with: 'Salmander Signage'
    click_button 'Update Merchant'

    expect(page).to have_current_path("/admin/merchants/#{@signs.id}?update=true")

    within("#merchant-#{@signs.id}") do
      expect(page).to have_content('Salmander Signage')
      expect(page).to_not have_content("Sal's Signs")
    end
  end

  it 'shows an error if I try to submit an empty name field' do
    fill_in 'Name', with: ''
    click_button 'Update Merchant'

    expect(page).to have_current_path("/admin/merchants/#{@signs.id}/edit")

    within('.alert') do
      expect(page).to have_content("Error: Name can't be blank")
    end
  end

  it 'shows a flash message confirming information update' do
    fill_in 'Name', with: 'Salmander Signage'
    click_button 'Update Merchant'

    expect(page).to have_current_path("/admin/merchants/#{@signs.id}?update=true")
    within('.confirm') do
      expect(page).to have_content('Merchant Successfully Updated')
    end
  end
end
