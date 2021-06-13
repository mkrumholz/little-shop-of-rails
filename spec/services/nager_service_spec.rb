require 'rails_helper'

RSpec.describe GithubService do
  describe '.holiday_info', :service do
    it 'queries public holiday info for the US on Nager.at' do
      WebMock.stub_request(:get, /date.nager.at/).
        with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Faraday v1.4.2'}).
        to_return(status: 200, body: [{date: "2021-07-05", localName: 'Independence Day'}, 
                                      {date: "2021-09-06", localName: "Labor Day"}].to_json,
                  headers: {})
                  
      uri = URI('https://date.nager.at/api/v2/NextPublicHolidays/US')

      response = NagerService.holiday_info

      expect(response[0][:date]).to eq '2021-07-05'
      expect(response[0][:localName]).to eq 'Independence Day'
      expect(response[1][:date]).to eq '2021-09-06'
      expect(response[1][:localName]).to eq 'Labor Day'
    end
  end 
end
