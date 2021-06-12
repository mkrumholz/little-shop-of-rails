require 'rails_helper'

RSpec.describe 'new discount page' do
  before :each do
    @merchant_1 = FactoryBot.create(:merchant)
    @merchant_2 = FactoryBot.create(:merchant)

    visit "/merchants/#{@merchant_1.id}/discounts/new"
  end

  it 'can create a new discount for the merchant' do
    fill_in :name, with: '11th item free'
    fill_in :percentage, with: 9.09
    fill_in :quantity_threshold, with: 11
    click_button 'Create'

    expect(current_path).to eq "/merchants/#{@merchant_1.id}/discounts"
    expect(page).to have_content '11th item free'
    expect(Merchant.discounts.last.percentage).to eq 0.0909
    expect(Merchant.discounts.last.quantity_threshold).to eq 11
  end

  it 'requires all fields be completed' do
    click_button 'Create'

    expect(current_path).to eq "/merchants/#{@merchant_1.id}/discounts/new"
    expect(page).to have_content "🛑 Error: Name can't be blank, Percentage can't be blank, Quantity threshold can't be blank"
  end

  it 'only allows 2 decimal places for the percentage' do
    fill_in :name, with: '11th item free'
    fill_in :percentage, with: 9.090909
    fill_in :quantity_threshold, with: 11
    click_button 'Create'

    expect(current_path).to eq "/merchants/#{@merchant_1.id}/discounts/new"
    expect(page).to have_content "🛑 Error: Percentage is not properly formatted"
  end

  it 'only allows integers for the quantity_threshold' do
    fill_in :name, with: '11th item free'
    fill_in :percentage, with: 9.09
    fill_in :quantity_threshold, with: 'eleven'
    click_button 'Create'

    expect(current_path).to eq "/merchants/#{@merchant_1.id}/discounts/new"
    expect(page).to have_content "🛑 Error: Quantity threshold must be a number"
  end
end
