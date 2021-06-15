class InvoiceItem < ApplicationRecord
  enum status: [:pending, :packaged, :shipped]
  belongs_to :invoice
  belongs_to :item

  def self.with_discounts(invoice_id, merchant_id)
    inner = joins(:item)
              .select( 'invoice_items.*, 
                      items.name as item_name,
                      d.id as discount_id,
                      d.name as discount_name, 
                      d.quantity_threshold,
                      d.percentage,
                      rank() over (partition by invoice_items.id order by percentage desc) rank')
              .joins('left join discounts d on d.merchant_id=items.merchant_id and invoice_items.quantity >= d.quantity_threshold')
              .where(invoice_id: invoice_id, items: {merchant_id: merchant_id}).to_sql

    InvoiceItem
      .select('t0.*')
      .from("(#{inner}) as t0")
      .where('rank = 1')
      .order('t0.item_name')
  end
end
