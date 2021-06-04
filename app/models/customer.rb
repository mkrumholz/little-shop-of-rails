class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy

  def self.top_five_completed_transactions
    joins(invoices: :transactions).where('transactions.result = 1').group([:last_name, :first_name]).order('count_status desc', :last_name).limit(5).count('status').to_a
  end

  def self.top_5_customers
    joins(invoices: :transactions).select("customers.*, COUNT(distinct transactions.id) as transaction_count")
    .where("transactions.result = ?", 1).group("customers.id").order("transaction_count desc").limit(5)
  end
end
