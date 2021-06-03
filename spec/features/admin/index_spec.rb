require 'rails_helper'

RSpec.describe 'index.html.erb' do
  describe 'visit' do
    it 'displays a dashboard' do
      visit '/admin'

      within('h1#dash') do
        expect(page).to have_content('Admin Dashboard')
      end
    end
    it 'has links to the merchants index' do
      visit '/admin'

      expect(page).to have_link('Merchants Index')
      click_link('Merchants Index')

      expect(page).to have_path('/admin/merchants')
    end
  end
end
