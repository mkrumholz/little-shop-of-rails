class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy

  def self.top_five_completed_transactions
    joins(invoices: :transactions)
    .where('transactions.result = 1')
    .select("customers.*, count(transactions.result) as tran_count")
    .order('tran_count desc', :last_name, :first_name)
    .group(:id)
    .limit(5)
  end
end
