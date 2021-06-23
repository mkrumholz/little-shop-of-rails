require 'rails_helper'

RSpec.describe 'Welcome page' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)

    visit '/'
  end

  describe 'visit' do
    it 'has a button to the admin index' do
      expect(page).to have_link('Admin Dashboard')

      click_link('Admin Dashboard')

      expect(page).to have_current_path('/admin')
    end

    it 'displays a selection of merchants' do
      expect(page).to have_content("Merchant ##{@merchant_1.id}")
      expect(page).to have_content("Merchant ##{@merchant_2.id}")
      expect(page).to have_content("Merchant ##{@merchant_3.id}")

      expect(page).to have_content(@merchant_1.name.to_s)
      expect(page).to have_content(@merchant_2.name.to_s)
      expect(page).to have_content(@merchant_3.name.to_s)
    end

    it 'provides links to merchant dashboards' do
      expect(page).to have_link("Merchant ##{@merchant_1.id}")
      expect(page).to have_link("Merchant ##{@merchant_2.id}")
      expect(page).to have_link("Merchant ##{@merchant_3.id}")

      click_link("Merchant ##{@merchant_1.id}")

      expect(page).to have_current_path("/merchants/#{@merchant_1.id}/dashboard")
    end
  end

  describe 'authorization flow' do
    it 'creates a new merchant' do
      visit '/'

      click_on 'Register as a Merchant' 

      expect(current_path).to eq(new_merchant_path)

      merchant_name = 'funbucket13'
      password = 'test'

      fill_in :name, with: merchant_name
      fill_in :merchant_password, with: password

      click_on 'Create Merchant Account'

      expect(page).to have_content("Welcome, #{merchant_name}!")
    end

    it 'can log in with valid credentials' do
      merchant = create(:merchant, name: 'FunBucket13', password: 'test')

      visit '/'

      click_on 'I already have an account'

      expect(current_path).to eq(login_path)

      fill_in :name, with: merchant.name
      fill_in :password, with: merchant.password

      click_on 'Log In'

      expect(current_path).to eq('/')

      expect(page).to have_content("Welcome, #{merchant.name}!")
    end

    it 'cannot log in with bad credentials' do
      merchant = create(:merchant, name: 'FunBucket13', password: 'test')

      visit login_path

      fill_in :name, with: merchant.name
      fill_in :password, with: 'incorrect password'

      click_on 'Log In'

      expect(current_path).to eq(login_path)

      expect(page).to have_content('🙅🏻‍♀️ Incorrect name or password')
    end
  end
end
