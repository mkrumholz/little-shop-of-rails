require 'rails_helper'

RSpec.describe 'footer' do
  before :each do
    visit '/admin'
  end
  
  it 'displays repo name' do
    within 'footer' do
      expect(page).to have_content('little-shop-of-rails')
    end
  end
  it 'displays contributor names and commits' do
    expect(page).to have_content('Contributor: Molly')
    expect(page).to have_content('Commits: 7')
    expect(page).to have_content('Contributor: Sid')
    expect(page).to have_content('Commits: 80')
  end
  it 'displays number of merged pulls' do
    expect(page).to have_content('Merged Pull Requests: 2')
  end
end
