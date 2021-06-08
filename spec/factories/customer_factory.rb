FactoryBot.define do
  factory :customer do
    sequence(:id) { |n| n}
    first_name { 'Audrey' }
    sequence(:last_name) {|n| "#{n}"}
  end
end