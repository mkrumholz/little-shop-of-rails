require 'rails_helper'

RSpec.describe 'New merchant page' do
  before :each do
    visit '/admin/merchants/new'
  end

  it 'has a form to create a new merchant' do
    expect(page).to have_field('Name')
    expect(page).to have_button('Create Merchant')
  end

  it 'does not let me submit the form without filling in a name' do
    fill_in 'Name', with: ''
    click_button('Create Merchant')

    expect(page).to have_current_path('/admin/merchants/new')
    expect(page).to have_content("Error: Name can't be blank")
  end

  it 'when I submit, I\'m redirected to the merchant admin index where my merchant shows as disabled' do
    fill_in 'Name', with: 'Cado Avocado Frozen Desserts'
    click_button('Create Merchant')

    expect(page).to have_current_path('/admin/merchants')
    within('#disabled') do
      expect(page).to have_content('Cado Avocado Frozen Desserts')
    end
  end
end
