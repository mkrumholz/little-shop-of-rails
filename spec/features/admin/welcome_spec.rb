require 'rails_helper'

Rspec.describe 'Welcome page' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Tims my time', status: false)
    @merchant_2 = Merchant.create!(name: 'Future Fun', status: false)
    @merchant_3 = Merchant.create!(name: 'Dozen a Dime', status: false)
    @merchant_4 = Merchant.create!(name: 'Fools Errant', status: false)
  end
  describe 'visit' do
     
  end
end
