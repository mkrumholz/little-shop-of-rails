
class Item < ApplicationRecord
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  belongs_to :merchant
  validates_presence_of :name, :description, :unit_price
  validates_inclusion_of :enabled, in: [true, false]

  def display_price
    price = (BigDecimal(unit_price)/100).to_f
    sprintf("$%#.2f", price)
  end

  def self.enabled_only
    where(enabled: true)
  end

  def self.disabled_only
    where(enabled: false)
  end
end
