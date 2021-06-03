require 'rails_helper'

RSpec.describe 'index.html.erb' do
  describe 'visit' do
    it 'displays a dashboard' do
      visit '/admin'

      within('h1#dash') do
        expect(page).to have_content('Admin Dashboard')
      end
    end
    it 'has links to the admin merchants index' do
      visit '/admin'
      save_and_open_page

      expect(page).to have_link('Merchants Index')
      click_link('Merchants Index')

      expect(page).to have_current_path('/admin/merchants')
    end
    it 'has links to the admin invoices index' do
      visit '/admin'

      expect(page).to have_link('Invoices Index')
      click_link('Invoices Index')

      expect(page).to have_current_path('/admin/invoices')
    end
  end
end
