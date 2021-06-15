FactoryBot.define do
  factory :invoice do
    status { :packaged }
    customer
  end
end
