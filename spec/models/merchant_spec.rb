require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do

    it { should have_many(:items).dependent(:destroy) }

  end

  describe 'instance methods' do
    it '#render_status returns Enabled or Disabled based on boolean status' do
      tees = Merchant.create!(name: "T-shirts by Terry", status: true)
      amphs = Merchant.create!(name: "All About Amphibians", status: false)

      expect(tees.render_status[:status]).to eq("Enabled")
      expect(tees.render_status[:action]).to eq("Disable")
      expect(amphs.render_status[:status]).to eq("Disabled")
      expect(amphs.render_status[:action]).to eq("Enable")
    end
  end
end
