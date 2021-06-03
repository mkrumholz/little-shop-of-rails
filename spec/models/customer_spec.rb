require 'rails_helper'

RSpec.describe Customer do
  describe 'relationships' do

    it { should have_many(:invoices).dependent(:destroy) }

  end
  describe 'class methods' do
    before :each do
      @merchant_1 = Merchant.create!(name: "Ralph's Monkey Hut")
      @customer_1 = Customer.create!(first_name: 'Madi', last_name: 'Johnson')
      @customer_2 = Customer.create!(first_name: 'Emmy', last_name: 'Lost')
      @customer_3 = Customer.create!(first_name: 'Shim', last_name: 'Stalone')
      @customer_4 = Customer.create!(first_name: 'Bado', last_name: 'Reason')
      @customer_5 = Customer.create!(first_name: 'Timothy', last_name: 'Richard')
      @customer_6 = Customer.create!(first_name: 'Alex', last_name: '19th')
      @invoice_1 = @customer_1.invoices.create!(status: 1)
      @invoice_2 = @customer_2.invoices.create!(status: 1)
      @invoice_3 = @customer_3.invoices.create!(status: 1)
      @invoice_4 = @customer_4.invoices.create!(status: 1)
      @invoice_5 = @customer_5.invoices.create!(status: 1)
      @invoice_6 = @customer_6.invoices.create!(status: 1)
      @invoice_4.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_4.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_4.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_4.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_4.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_6.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_6.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_6.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_6.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_5.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_5.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_5.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_1.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_1.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
      @invoice_3.transactions.create!(result: 1, credit_card_number: '534', credit_card_expiration_date: 'null')
    end
    describe '#top_five_completed_transactions' do
      it 'returns the 5 customers with the most completed transactions' do
        actual = [
        [["Reason", "Bado"], 5],
        [["19th", "Alex"], 4],
        [["Richard", "Timothy"], 3],
        [["Johnson", "Madi"], 2],
        [["Stalone", "Shim"], 1]
        ]
        expect(Customer.top_five_completed_transactions).to eq(actual)
      end
    end
  end
end
