require 'rails_helper'

RSpec.describe GithubService do
  describe '.holiday_info', :service do
    it 'queries public holiday info for the US on Nager.at', :vcr do
      response = NagerService.holiday_info

      expect(response[0][:date]).to eq '2021-09-06'
      expect(response[0][:localName]).to eq 'Labor Day'
      expect(response[1][:date]).to eq '2021-10-11'
      expect(response[1][:localName]).to eq 'Columbus Day'
    end
  end
end
