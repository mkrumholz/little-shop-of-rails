require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do

    it { should have_many(:items).dependent(:destroy) }

  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'callbacks' do
      it 'after_initialization it sets status to false if nil' do
        test = Merchant.create!(name: "test")
        expect(test.status).to eq(false)
      end
  end

  before :each do
    @merch_1 = Merchant.create!(name: "Sal's Signs", status: true)
    @merch_2 = Merchant.create!(name: "T-shirts by Terry", status: true)
    @merch_3 = Merchant.create!(name: "All About Amphibians", status: false)
    @merch_4 = Merchant.create!(name: "Will's Widdles", status: true)
    @merch_5 = Merchant.create!(name: "Rugula by Ron", status: true)
    @merch_6 = Merchant.create!(name: "Gemeni Gems", status: false)

    @item_1 = @merch_1.items.create!(name: 'thing1', description: 'thing1 is a thing', unit_price: 10)
    @item_2 = @merch_1.items.create!(name: 'thing2', description: 'thing1 is a thing', unit_price: 10)
    @item_3 = @merch_2.items.create!(name: 'thing1', description: 'thing1 is a thing', unit_price: 1)
    @item_4 = @merch_2.items.create!(name: 'thing2', description: 'thing2 is a thing', unit_price: 1)
    @item_5 = @merch_3.items.create!(name: 'thing1', description: 'thing1 is a thing', unit_price: 10)
    @item_6 = @merch_3.items.create!(name: 'thing2', description: 'thing2 is a thing', unit_price: 10)
    @item_7 = @merch_4.items.create!(name: 'thing1', description: 'thing1 is a thing', unit_price: 10)
    @item_8 = @merch_4.items.create!(name: 'thing2', description: 'thing2 is a thing', unit_price: 10)
    @item_9 = @merch_5.items.create!(name: 'thing1', description: 'thing1 is a thing', unit_price: 10)
    @item_10 = @merch_5.items.create!(name: 'thing2', description: 'thing2 is a thing', unit_price: 10)
    @item_11 = @merch_6.items.create!(name: 'thing1', description: 'thing1 is a thing', unit_price: 10)
    @item_12 = @merch_6.items.create!(name: 'thing2', description: 'thing2 is a thing', unit_price: 10)

    @customer = Customer.create!(first_name: "Sam", last_name: "Shmo")

    @invoice_1 = @customer.invoices.create!(status: 1)
    @invoice_2 = @customer.invoices.create!(status: 1)

    @transaction_1 = @invoice_1.transactions.create!(credit_card_number: "123123123", credit_card_expiration_date: "", result: 1)
    @transaction_2 = @invoice_1.transactions.create!(credit_card_number: "123123123", credit_card_expiration_date: "", result: 0)
    @transaction_3 = @invoice_2.transactions.create!(credit_card_number: "123123123", credit_card_expiration_date: "", result: 0)
    @transaction_4 = @invoice_2.transactions.create!(credit_card_number: "123123123", credit_card_expiration_date: "", result: 0)

    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 10, unit_price: 100, status: 2)
    @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 10, unit_price: 100, status: 2)
    @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_1.id, quantity: 2, unit_price: 10, status: 2)
    @invoice_item_4 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_2.id, quantity: 2, unit_price: 10, status: 2)
    @invoice_item_5 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_1.id, quantity: 15, unit_price: 100, status: 2)
    @invoice_item_6 = InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_2.id, quantity: 15, unit_price: 100, status: 2)
    @invoice_item_7 = InvoiceItem.create!(item_id: @item_7.id, invoice_id: @invoice_1.id, quantity: 2, unit_price: 100, status: 2)
    @invoice_item_8 = InvoiceItem.create!(item_id: @item_8.id, invoice_id: @invoice_2.id, quantity: 2, unit_price: 100, status: 2)
    @invoice_item_9 = InvoiceItem.create!(item_id: @item_9.id, invoice_id: @invoice_1.id, quantity: 20, unit_price: 100, status: 2)
    @invoice_item_10 = InvoiceItem.create!(item_id: @item_10.id, invoice_id: @invoice_2.id, quantity: 20, unit_price: 100, status: 2)
    @invoice_item_11 = InvoiceItem.create!(item_id: @item_11.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 100, status: 2)
    @invoice_item_12 = InvoiceItem.create!(item_id: @item_12.id, invoice_id: @invoice_2.id, quantity: 5, unit_price: 100, status: 2)
  end

  describe 'instance methods' do
    it '#render_status returns Enabled or Disabled based on boolean status' do
      expect(@merch_2.render_status[:status]).to eq("Enabled")
      expect(@merch_2.render_status[:action]).to eq("Disable")
      expect(@merch_3.render_status[:status]).to eq("Disabled")
      expect(@merch_3.render_status[:action]).to eq("Enable")
    end
  end

  describe 'class methods' do
    it '.enabled merchants returns merchantes with status = true' do
      expect(Merchant.enabled.count).to eq(4)
      expect(Merchant.enabled.first).to eq(@merch_1)
      expect(Merchant.enabled.last).to eq(@merch_5)
    end

    it '.disabled merchants returns merchantes with status = false' do
      expect(Merchant.disabled.count).to eq(2)
      expect(Merchant.disabled.first).to eq(@merch_3)
      expect(Merchant.disabled.last).to eq(@merch_6)
    end

    it '.top_5_total_revenue returns the top 5 merchants by total revenue generated' do
      expect(Merchant.top_5_total_revenue.first.id).to eq(@merch_5.id)
      expect(Merchant.top_5_total_revenue.second.id).to eq(@merch_3.id)
      expect(Merchant.top_5_total_revenue.third.id).to eq(@merch_1.id)
      expect(Merchant.top_5_total_revenue.fourth.id).to eq(@merch_6.id)
      expect(Merchant.top_5_total_revenue.last.id).to eq(@merch_4.id)
    end
  end
end
