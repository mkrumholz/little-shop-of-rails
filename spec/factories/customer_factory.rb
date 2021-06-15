FactoryBot.define do
  factory :customer do
    sequence(:id) { |n| n }
    first_name { 'Audrey' }
    sequence(:last_name) { |n| n.to_s }

    factory :customer_with_invoices do
      transient do
        invoices_count { 5 }
      end

      after(:create) do |customer, evaluator|
        create_list(:invoice, evaluator.invoices_count, customer: customer)
      end
    end
  end
end
