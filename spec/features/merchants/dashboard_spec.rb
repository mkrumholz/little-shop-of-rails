require 'rails_helper'

RSpec.describe 'Dashboard' do
  describe 'dashboard' do
    it 'can see the name of the merchants' do
      # Merchant Dashboard
      # As a merchant,
      # When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
      # Then I see the name of my merchant

      merchant = Merchant.create!(name: 'Schroeder-Jerde')

      visit "/merchants/#{merchant.id}/dashboards"

      expect(page).to have_content(merchant.name)
    end

    it 'can see the name of the merchants' do
      # Merchant Dashboard Links
      # As a merchant,
      # When I visit my merchant dashboard
      # Then I see link to my merchant items index (/merchants/merchant_id/items)
      # And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)

      merchant = Merchant.create!(name: 'Schroeder-Jerde')

      visit "/merchants/#{merchant.id}/dashboards"

      expect(page).to have_link("My Items")
      expect(page).to have_link("My Invoices")
      # click_link("My Items")
      #
      # expect(page).to have_current_path("/merchants/#{merchant.id}/items")
      #
      # click_link("My Invoices")
      #
      # expect(page).to have_current_path("/merchants/#{merchant.id}/invoices")
    end
  end
end
