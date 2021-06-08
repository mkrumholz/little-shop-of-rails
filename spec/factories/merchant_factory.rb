FactoryBot.define do
  factory :merchant do
    sequence(:id) { |n| n}
    name { 'Little Shop of Horrors' }
  end
end