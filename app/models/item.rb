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

  def self.ready_to_ship
    joins(invoices: :invoice_items)
    .select("items.*, invoices.id AS invoice_id, invoices.created_at AS invoice_creation")
    .where("invoice_items.status = 1")
    .group("items.id, invoices.id")
    .order("invoice_creation asc")
  end
end
