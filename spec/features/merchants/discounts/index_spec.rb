require 'rails_helper'

RSpec.describe 'merchant discount index' do
  before :each do
    @merchant_1 = FactoryBot.create(:merchant)
    @merchant_2 = FactoryBot.create(:merchant)

    # merchant_1 discounts
    @discount_1 = @merchant_1.discounts.create!(name: '4 or More', percentage: 0.1000, quantity_threshold: 4)
    @discount_2 = @merchant_1.discounts.create!(name: '20% for 10', percentage: 0.2000, quantity_threshold: 10)

    # merchant_2 discounts
    @discount_3 = @merchant_2.discounts.create!(name: 'BOGO', percentage: 0.5000, quantity_threshold: 2)

    visit "/merchants/#{@merchant_1.id}/discounts"
  end

  it 'displays the names of all of the merchant discounts' do
    expect(page).to have_content @discount_1.name
    expect(page).to have_content @discount_2.name
  end

  it 'does not display discounts for other merchants' do
    expect(page).to_not have_content @discount_3.name
  end

  it 'displays the percentages and quantity_thresholds of each discount' do
    within "tr#discount-#{@discount_1.id}" do
      expect(page).to have_content '10.00%'
      expect(page).to have_content @discount_1.quantity_threshold
    end
    within "tr#discount-#{@discount_2.id}" do
      expect(page).to have_content '20.00%'
      expect(page).to have_content @discount_2.quantity_threshold
    end
  end

  it 'has a link to each discount show page' do
    within "tr#discount-#{@discount_1.id}" do
      click_on @discount_1.name.to_s
    end

    expect(current_path).to eq "/merchants/#{@merchant_1.id}/discounts/#{@discount_1.id}"
  end

  it 'has a link to create a new discount' do
    click_on 'New discount'

    expect(current_path).to eq "/merchants/#{@merchant_1.id}/discounts/new"
  end
end
