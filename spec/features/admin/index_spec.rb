require 'rails_helper'

RSpec.describe 'index.html.erb' do
  describe 'visit' do
    it 'displays a dashboard' do
      visit '/admin'

      within('h1#dash') do
        expect(page).to have_content('Admin Dashboard')
      end
    end
  end
end
