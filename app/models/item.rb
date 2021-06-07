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
    joins(invoices: :transactions)
    .where(transactions: {result: 1}, invoices: {status: 1})
    .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .group(:id)
    .order(revenue: :desc)
    .limit(5)
  end

  def best_revenue_date
    Invoice.highest_revenue_date(id)
  end

  def self.ready_to_ship
    joins(invoices: :invoice_items)
    .select("items.*, invoices.id AS invoice_id, invoices.created_at AS invoice_creation")
    .where(invoice_items: {status: 1})
    .group("items.id, invoices.id")
    .order("invoice_creation asc")
  end

  def self.merchant_invoices
    joins(:invoices)
    .select("invoices.id")
    .distinct
  end
end
