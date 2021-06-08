FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number { '1111222233334444'}
    credit_card_expiration_date { Date.today + 5.years }
    result { :success }
  end
end