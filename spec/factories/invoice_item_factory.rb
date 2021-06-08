FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity
    sequence :unit_price do |p|
      500 + (1000 * p)
    end
    status { :completed }
  end
end