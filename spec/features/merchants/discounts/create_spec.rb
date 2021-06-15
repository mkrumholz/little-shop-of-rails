require 'rails_helper'

RSpec.describe 'new discount page' do
  before :each do
    allow(NagerHoliday).to receive(:next_3_holidays).and_return([
      { date: '2021-07-05', localName: 'Independence Day' },
      { date: '2021-09-06', localName: 'Labor Day' },
      { date: '2021-10-11', localName: 'Columbus Day' },
      { date: '2021-11-11', localName: 'Veterans Day' }
    ])

    @merchant_1 = FactoryBot.create(:merchant)
    @merchant_2 = FactoryBot.create(:merchant)

    visit "/merchants/#{@merchant_1.id}/discounts/new"
  end

  it 'can create a new discount for the merchant' do
    fill_in 'discount[name]', with: '11th item free'
    fill_in 'discount[percentage]', with: 9.09
    fill_in 'discount[quantity_threshold]', with: 11
    click_button 'Create Discount'

    expect(current_path).to eq "/merchants/#{@merchant_1.id}/discounts"
    expect(page).to have_content '11th item free'
    expect(@merchant_1.discounts.last.percentage.to_f).to eq 0.0909
    expect(@merchant_1.discounts.last.quantity_threshold).to eq 11
  end

  it 'requires all fields be completed' do
    click_button 'Create Discount'

    expect(current_path).to eq "/merchants/#{@merchant_1.id}/discounts/new"
    expect(page).to have_content "🛑 Error: Name can't be blank, Quantity threshold can't be blank, Quantity threshold is not a number"
  end

  it 'percentage must be between 0 and 100 percent' do
    fill_in 'discount[name]', with: '11th item free'
    fill_in 'discount[percentage]', with: 900.00
    fill_in 'discount[quantity_threshold]', with: 11
    click_button 'Create Discount'

    expect(current_path).to eq "/merchants/#{@merchant_1.id}/discounts/new"
    expect(page).to have_content '🛑 Error: Percentage must be less than or equal to 1.0'
  end

  it 'only allows integers for the quantity_threshold' do
    fill_in 'discount[name]', with: '11th item free'
    fill_in 'discount[percentage]', with: 9.09
    fill_in 'discount[quantity_threshold]', with: 'eleven'
    click_button 'Create Discount'

    expect(current_path).to eq "/merchants/#{@merchant_1.id}/discounts/new"
    expect(page).to have_content '🛑 Error: Quantity threshold is not a number'
  end

  it 'can fill in fields for a holiday discount, when relevant' do
    visit "/merchants/#{@merchant_1.id}/discounts"

    click_button 'Create Independence Day Discount'

    expect(current_path).to eq "/merchants/#{@merchant_1.id}/discounts/new"
    expect(page).to have_selector("input[value='Independence Day discount']")
    expect(page).to have_selector("input[value='30.0']")
    expect(page).to have_selector("input[value='2']")

    fill_in 'discount[percentage]', with: 25.0

    click_button 'Create Discount'

    expect(current_path).to eq "/merchants/#{@merchant_1.id}/discounts"
    expect(page).to have_content 'Independence Day discount'
    expect(@merchant_1.discounts.last.percentage.to_f).to eq 0.25
    expect(@merchant_1.discounts.last.quantity_threshold).to eq 2
  end
end
