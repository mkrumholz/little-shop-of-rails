FactoryBot.define do
  factory :item do
    name
    description
    sequence :unit_price do |p|
      1000 + (1000 * p)
    end
    merchant
  end
end