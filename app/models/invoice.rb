class Invoice < ApplicationRecord
  enum status: [:in_progress, :completed, :cancelled]

  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :transactions

  validates :customer_id, presence: true
  validates :status, presence: true

  def self.unshipped_items
    joins(:invoice_items)
      .where('invoice_items.status != 2')
      .select('invoices.*')
      .group('invoices.id')
      .order('invoices.created_at asc')
  end

  def item_sale_price
    items
      .select('items.*, invoice_items.unit_price as sale_price, invoice_items.quantity as sale_quantity')
  end

  def items_with_discounts(merchant_id)
    InvoiceItem.with_discounts(id, merchant_id)
  end

  def total_revenue
    invoice_items
      .sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def total_revenue_for_merchant(merchant_id)
    items
      .where(merchant_id: merchant_id)
      .sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def discounted_revenue_for_merchant(merchant_id)
    inner = items.select('invoice_items.id, sum(invoice_items.quantity * invoice_items.unit_price) as revenue,
                          (select max(discounts.percentage) from discounts where discounts.merchant_id=items.merchant_id and discounts.quantity_threshold <= invoice_items.quantity) as discount')
                 .where(merchant_id: merchant_id)
                 .group('invoice_items.id, items.merchant_id').to_sql

    Invoice.select('sum(case when discount is not null then (revenue - (discount * revenue)) else revenue end) rev_end')
           .from("(#{inner}) as t0")
           .take.rev_end.to_i
  end
end
