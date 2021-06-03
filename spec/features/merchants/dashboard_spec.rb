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
  end
end
