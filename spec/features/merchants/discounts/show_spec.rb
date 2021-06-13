require 'rails_helper'

RSpec.describe 'discount show page' do
  it 'displays the name and details for the discount' do
    merchant_1 = FactoryBot.create(:merchant)
    discount_1 = merchant_1.discounts.create!(name: '4 or More', percentage: 0.1000, quantity_threshold: 4)
    discount_2 = merchant_1.discounts.create!(name: '20% for 10', percentage: 0.2000, quantity_threshold: 10)

    visit "/merchants/#{merchant_1.id}/discounts/#{discount_1.id}"

    expect(page).to have_content discount_1.name
    expect(page).to have_content '10.00%'
    expect(page).to have_content discount_1.quantity_threshold
  end
end
