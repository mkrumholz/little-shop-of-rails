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

  it 'has a button to enable or disable each merchant' do
    within("#merchant-#{@signs.id}") do
      expect(page).to have_button("Disable")
      expect(page).to_not have_button("Enable")
    end
    within("#merchant-#{@tees.id}") do
      expect(page).to have_button("Disable")
      expect(page).to_not have_button("Enable")
    end
    within("#merchant-#{@amphs.id}") do
      expect(page).to have_button("Enable")
      expect(page).to_not have_button("Disable")
    end
  end

  it 'on clicking the button, it updates merchant status and returns to the index page' do
    within("#merchant-#{@signs.id}") do
      click_button "Disable"
      expect(page).to have_current_path('/admin/merchants')
      expect(page).to have_button("Enable")
      expect(page).to_not have_button("Disable")
    end
    within("#merchant-#{@tees.id}") do
      click_button "Disable"
      expect(page).to have_current_path('/admin/merchants')
      expect(page).to have_button("Enable")
      expect(page).to_not have_button("Disable")
    end
    within("#merchant-#{@amphs.id}") do
      click_button "Enable"
      expect(page).to have_current_path('/admin/merchants')
      expect(page).to have_button("Disable")
      expect(page).to_not have_button("Enable")
    end
  end

  it 'shows merchants in sections based on status' do
    within("#enabled") do
      expect(page).to have_content("Enabled Merchants")
      expect(page).to have_content(@signs.name)
      expect(page).to have_content(@tees.name)
      expect(page).to_not have_content(@amphs.name)
    end
    within("#disabled") do
      expect(page).to have_content("Disabled Merchants")
      expect(page).to_not have_content(@signs.name)
      expect(page).to_not have_content(@tees.name)
      expect(page).to have_content(@amphs.name)
    end
  end

  it 'shows a link to create a new merchant that redirects to a create form' do
    expect(page).to have_link("New Merchant", :href => "/admin/merchants/new")
  end
end
