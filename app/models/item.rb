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

  def highest_revenue_date
    invoices.joins(:transactions)
    .select(invoices: :updated_at)
    .where(transactions: {result: 1}, invoices: {status: 1})
    .order(Arel.sql('sum(invoice_items.quantity * invoice_items.unit_price) desc, invoices.updated_at desc'))
    .group(:updated_at)
    .pluck(:updated_at)
    .first.to_date
  end

  def self.ready_to_ship
    joins(:invoices)
    .select("items.*, invoice_items.*, invoices.id AS invoice_id, invoices.created_at AS invoice_creation")
    .where(invoice_items: {status: 1})
    .group("items.id, invoices.id, invoice_items.id")
    .order("invoice_creation asc")
  end

  def self.merchant_invoices
    joins(:invoices)
    .select("invoices.id")
    .distinct
  end
end
