FactoryBot.define do
  factory :merchant do
    sequence(:id) { |n| n }
    sequence(:name) { |n| "Little Shop of #{n} Horror(s)" }

    factory :merchant_with_items do
      transient do
        items_count { 5 }
      end

      after(:create) do |merchant, evaluator|
        create_list(:item, evaluator.items_count, merchant: merchant)
      end
    end
  end
end
