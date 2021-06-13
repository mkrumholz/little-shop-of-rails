require 'rails_helper'

RSpec.describe NagerHoliday do
  describe '.next_3_holidays' do
    it 'returns the name and date of the next 3 US public holidays' do
      allow(NagerService).to receive(:holiday_info).and_return([{
        date: '2021-07-05',
        localName: 'Independence Day'
      }, {
        date: '2021-09-06',
        localName: 'Labor Day'
      }, {
        date: '2021-10-11',
        localName: 'Columbus Day'
      },{
        date: '2021-11-11',
        localName: 'Veterans Day'
      }])

      holiday_1 = {date: '2021-07-05', localName: 'Independence Day'}
      holiday_2 = {date: '2021-09-06', localName: 'Labor Day'}
      holiday_3 = {date: '2021-10-11', localName: "Indigenous Peoples' Day"}

      expect(NagerHoliday.next_3_holidays).to eq([holiday_1, holiday_2, holiday_3])
    end
  end
end
