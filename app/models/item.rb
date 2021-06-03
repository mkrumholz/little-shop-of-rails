
class Item < ApplicationRecord
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  def display_price
    price = (BigDecimal(unit_price)/100).to_f
    sprintf("$%#.2f", price)
  end
end
