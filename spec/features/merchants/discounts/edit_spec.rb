require 'rails_helper'

RSpec.describe 'merchant discount edit' do
  before :each do
    @merchant_1 = FactoryBot.create(:merchant)
    @discount_1 = @merchant_1.discounts.create!(name: '4 or More', percentage: 0.1000, quantity_threshold: 4)

    visit "/merchants/#{@merchant_1.id}/discounts/#{@discount_1.id}/edit"
  end

  it 'can update just the discount name' do
    fill_in 'discount[name]', with: '5 or more'
    click_button 'Update Discount'

    expect(page).to have_content '5 or more'
    expect(page).to have_content '10.00%'
    expect(page).to have_content @discount_1.quantity_threshold
  end

  it 'can update just the discount percentage' do
    fill_in 'discount[percentage]', with: 15.00
    click_button 'Update Discount'

    expect(page).to have_content @discount_1.name
    expect(page).to have_content '15.00%'
    expect(page).to have_content @discount_1.quantity_threshold
  end

  it 'can update just the quantity threshold' do
    expect(page).to_not have_content 5

    fill_in 'discount[percentage]', with: 5
    click_button 'Update Discount'

    expect(page).to have_content @discount_1.name
    expect(page).to have_content '10.00%'
    expect(page).to have_content 5
  end
end
