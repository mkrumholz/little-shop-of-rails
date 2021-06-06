require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'relationships' do

    it { should belong_to(:invoice) }
    it { should belong_to(:item) }

  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values([:pending, :packaged, :shipped])}
  end
end
