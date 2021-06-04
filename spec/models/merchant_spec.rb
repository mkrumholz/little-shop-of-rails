require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do

    it { should have_many(:items).dependent(:destroy) }

  end

  before :each do
    @signs = Merchant.create!(name: "Sal's Signs", status: true)
    @tees = Merchant.create!(name: "T-shirts by Terry", status: true)
    @amphs = Merchant.create!(name: "All About Amphibians", status: false)
  end

  describe 'instance methods' do
    it '#render_status returns Enabled or Disabled based on boolean status' do
      expect(@tees.render_status[:status]).to eq("Enabled")
      expect(@tees.render_status[:action]).to eq("Disable")
      expect(@amphs.render_status[:status]).to eq("Disabled")
      expect(@amphs.render_status[:action]).to eq("Enable")
    end
  end

  describe 'class methods' do
    it '.enabled merchants returns merchantes with status = true' do
      expect(Merchant.enabled.count).to eq(2)
      expect(Merchant.enabled.first).to eq(@signs)
      expect(Merchant.enabled.last).to eq(@tees)
    end
    
    it '.disabled merchants returns merchantes with status = false' do
      expect(Merchant.disabled.count).to eq(1)
      expect(Merchant.disabled.first).to eq(@amphs)
    end
  end
end
