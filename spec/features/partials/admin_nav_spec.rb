require 'rails_helper'

RSpec.describe 'admin header nav' do
  before :each do
    allow(GithubService).to receive(:contributors_info).and_return([
                                                                     { id: 26797256, name: 'Molly', contributions: 7 },
                                                                     { id: 78388882, name: 'Sid', contributions: 80 }
                                                                   ])
    allow(GithubService).to receive(:pull_request_info).and_return([
                                                                { id: 0o101010011, name: 'Molly', merged_at: 7 },
                                                                { id: 0o1011230011, name: 'Sid', merged_at: 80 },
                                                                { id: 0o1011230011, name: 'Sid', merged_at: nil }
                                                              ])
    allow(GithubService).to receive(:repo_info).and_return({
                                                             name: 'little-esty-shop'
                                                           })

    visit '/admin'
  end

  it 'links to the admin dashboard' do
    expect(page).to have_link('Dashboard')
    click_link('Dashboard')

    expect(page).to have_current_path('/admin')
  end

  it 'links to the admin merchants index' do
    expect(page).to have_link('Merchants')
    click_link('Merchants')

    expect(page).to have_current_path('/admin/merchants')
  end

  it 'links to the admin invoices index' do
    expect(page).to have_link('Invoices')
    click_link('Invoices')

    expect(page).to have_current_path('/admin/invoices')
  end
end
