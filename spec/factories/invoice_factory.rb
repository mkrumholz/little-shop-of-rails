FactoryBot.define do
  factory :invoice do
    customer
    
    trait :in_progress do
      status :in_progress
    end

    trait :completed do
      status :completed
    end

    trait :cancelled do
      status :cancelled
    end
  end
end 

# FactoryBot.define do
#   factory :invoice_item do
#     item
#     invoice
#     quantity
#     sequence :unit_price do |p|
#       500 + (1000 * p)
#     end
#     status { :completed }
#   end

#   factory :invoice do
#     customer
#     status { :completed } 
#   end

#   factory :item do
#     name
#     description
#     sequence :unit_price do |p|
#       1000 + (1000 * p)
#     end
#     merchant
#   end

#   factory :customer do
#     first_name { "Arya" }
#     last_name { "Stark" }
#   end

#   factory :merchant do
#     name
#   end

#   factory :transaction do
#     invoice
#     credit_card_number { '1111222233334444'}
#     credit_card_expiration_date { Date.today + 5.years }
#     result { :success }
#   end
# end