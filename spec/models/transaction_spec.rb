require 'rails_helper'

RSpec.describe Transaction do
  describe 'relationships' do
    it { should belong_to(:invoice) }
  end

  describe 'enums' do
    it { should define_enum_for(:result)}
  end
end
