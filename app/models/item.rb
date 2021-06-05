class Item < ApplicationRecord
  include Dollarable

  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  belongs_to :merchant
  validates_presence_of :name, :description, :unit_price
  validates_inclusion_of :enabled, in: [true, false]

  def price_to_dollars
    price_in_dollars(unit_price)
  end

  def self.enabled_only
    where(enabled: true)
  end

  def self.disabled_only
    where(enabled: false)
  end

  def self.top_5_by_revenue 
    joins(:invoice_items)
    .joins('right join invoices on invoices.id=invoice_items.invoice_id')
    .joins('right join transactions on transactions.invoice_id=invoices.id')
    .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .where(transactions: {result: 1})
    .where(invoices: {status: 1})
    .group(:id)
    .order(revenue: :desc)
    .limit(5)
  end
end
