require 'rails_helper'

RSpec.describe 'merchant discount index' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    # merchant_1 discounts
    @discount_1 = @merchant_1.discounts.create!(name: '4 or More', percentage: 0.1000, quantity_threshold: 4)
    @discount_2 = @merchant_1.discounts.create!(name: '20% for 10', percentage: 0.2000, quantity_threshold: 10)

    # merchant_2 discounts
    @discount_3 = @merchant_2.discounts.create!(name: 'BOGO', percentage: 0.5000, quantity_threshold: 2)

    visit "/merchants/#{@merchant_1.id}/discounts"
  end

  it 'displays the names of all of the merchant discounts', :vcr do
    expect(page).to have_content @discount_1.name
    expect(page).to have_content @discount_2.name
  end

  it 'does not display discounts for other merchants', :vcr do
    expect(page).to_not have_content @discount_3.name
  end

  it 'displays the percentages and quantity_thresholds of each discount', :vcr do
    within "tr#discount-#{@discount_1.id}" do
      expect(page).to have_content '10.00%'
      expect(page).to have_content @discount_1.quantity_threshold
    end
    within "tr#discount-#{@discount_2.id}" do
      expect(page).to have_content '20.00%'
      expect(page).to have_content @discount_2.quantity_threshold
    end
  end

  it 'has a link to each discount show page', :vcr do
    within "tr#discount-#{@discount_1.id}" do
      click_on @discount_1.name.to_s
    end

    expect(current_path).to eq "/merchants/#{@merchant_1.id}/discounts/#{@discount_1.id}"
  end

  it 'has a link to create a new discount', :vcr do
    click_on 'New discount'

    expect(current_path).to eq "/merchants/#{@merchant_1.id}/discounts/new"
  end

  it 'has a link to delete each discount', :vcr do
    within "tr#discount-#{@discount_1.id}" do
      click_button 'Delete'
    end

    expect(page).to_not have_content @discount_1.name
    expect(page).to have_content @discount_2.name
  end

  it 'displays the next 3 public holidays', :vcr do
    within 'section#holidays' do
      expect(page).to have_content 'Upcoming Holidays'
      expect(page).to have_content 'Labor Day'
      expect(page).to have_content 'Observed: Monday, September 06, 2021'
      expect(page).to have_content "Indigenous Peoples' Day"
      expect(page).to have_content 'Observed: Monday, October 11, 2021'
      expect(page).to have_content 'Veterans Day'
      expect(page).to have_content 'Observed: Thursday, November 11, 2021'
      expect(page).to_not have_content 'Thanksgiving'
    end
  end

  it 'has a link to create a holiday discount for each holiday', :vcr do
    within 'section#holidays' do
      click_button 'Create Labor Day Discount'
    end

    expect(current_path).to eq "/merchants/#{@merchant_1.id}/discounts/new"
  end

  it 'has a link to the discount if a discount for the holiday already exists', :vcr do
    holiday_discount = @merchant_1.discounts.create!(name: 'Labor Day discount', percentage: 0.25, quantity_threshold: 2)

    visit "/merchants/#{@merchant_1.id}/discounts"

    within 'section#holidays' do
      expect(page).to_not have_button 'Create Labor Day Discount'
      click_link 'View discount'
    end

    expect(current_path).to eq "/merchants/#{@merchant_1.id}/discounts/#{holiday_discount.id}"
  end
end
