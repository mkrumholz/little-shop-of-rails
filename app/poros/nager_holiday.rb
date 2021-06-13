class NagerHoliday
  def self.next_3_holidays
    next_3 = NagerService.holiday_info[0..2]
    delete_columbus(next_3)
  end

  def self.delete_columbus(holidays)
    holidays.each do |holiday|
      holiday[:localName] = "Indigenous Peoples' Day" if holiday[:localName] == 'Columbus Day'
    end
    holidays
  end
end
