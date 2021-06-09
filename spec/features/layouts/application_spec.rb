require 'rails_helper'

RSpec.describe 'footer' do
  before :each do
    allow(GithubService).to receive(:contributors_info).and_return([
      {id: 26797256, login: 'Molly', contributions: 7},
      {id: 78388882, login: 'Sa', contributions: 80}
    ])
    allow(GithubService).to receive(:closed_pulls).and_return([
      {id: '0101010011', name: 'Molly', merged_at: 7},
      {id: '01011230011', name: 'Sa',merged_at: 80},
      {id: '01011230011', name: 'Sa', merged_at: nil}
    ])
    allow(GithubService).to receive(:repo_info).and_return({
        name: 'little-esty-shop'
    })
    visit '/admin'
  end
  it 'displays repo name' do
    within 'footer' do
      expect(page).to have_content('little-esty-shop')
    end
  end
  it 'displays contributor names and commits' do
    expect(page).to have_content('Contributor: Molly')
    expect(page).to have_content('Commits: 7')
    expect(page).to have_content('Contributor: Sa')
    expect(page).to have_content('Commits: 80')
  end
  it 'displays number of merged pulls' do

    expect(page).to have_content('Merged Pull Requests: 2')
  end
end
