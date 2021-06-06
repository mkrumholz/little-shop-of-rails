class Invoice < ApplicationRecord
  enum status: [:in_progress, :completed, :cancelled]

  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :transactions

  def self.unshipped_items
    joins(:invoice_items)
    .where('invoice_items.status != 2')
    .select('invoices.*')
    .group('invoices.id')
    .order('invoices.created_at asc')
  end

  def self.highest_revenue_date(item_id)
    joins(:invoice_items)
    .joins('right join transactions on transactions.invoice_id=invoices.id')
    .select('invoices.updated_at as date')
    .where(invoice_items: {item_id: item_id}, transactions: {result: 1}, invoices: {status: 1})
    .order(Arel.sql('sum(invoice_items.quantity * invoice_items.unit_price) desc, invoices.updated_at desc'))
    .group('invoices.updated_at')
    .limit(1)
    .pluck('invoices.updated_at')
  end
end
