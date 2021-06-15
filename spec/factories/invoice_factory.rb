FactoryBot.define do
  factory :invoice do
    status { :completed }
    customer
  end
end
