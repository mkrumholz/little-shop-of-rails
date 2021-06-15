FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity { 2 }
    sequence :unit_price do |p|
      500 + (1000 * p)
    end
    status { :packaged }
  end
end
