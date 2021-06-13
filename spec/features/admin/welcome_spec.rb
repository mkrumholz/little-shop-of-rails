require 'rails_helper'

RSpec.describe 'Welcome page' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Tims my time', status: false)
    @merchant_2 = Merchant.create!(name: 'Future Fun', status: false)
    @merchant_3 = Merchant.create!(name: 'Dozen a Dime', status: false)

    visit '/'
  end
  
  describe 'visit' do
    it 'has a button to the admin index' do
      expect(page).to have_link('Admin Index')

      click_link('Admin Index')

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
end
