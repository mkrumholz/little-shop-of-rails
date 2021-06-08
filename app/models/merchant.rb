class Merchant < ApplicationRecord

  has_many :items, dependent: :destroy
  after_initialize :init

  validates :name, presence: true

  def init
    self.status = false if self.status.nil?
  end

  def render_status
    if self.status
      {status: "Enabled", action: "Disable"}
    else
      {status: "Disabled", action: "Enable"}
    end
  end

  def top_selling_date
    output = items.select('invoices.created_at AS top_selling_date,
                 SUM(invoice_items.unit_price * invoice_items.quantity) AS top_revenue')
         .joins(invoice_items: {invoice: :transactions})
         .where(transactions: {result: 1})
         .group('invoices.created_at')
         .order('invoices.created_at DESC, top_revenue DESC')
         .limit(1)

   output.first.top_selling_date
  end

  def items_of_merchant
    items.merchant_invoices
  end

  def self.enabled
    where(status: true)
  end

  def self.disabled
    where(status: false)
  end

  def self.top_5_total_revenue
    select('merchants.*,
            invoices.id as invoice_id,
            sum(invoice_items.unit_price * invoice_items.quantity) AS revenue')
    .joins(items: {invoice_items: {invoice: :transactions}})
    .where(transactions: {result: 1})
    .group('merchants.id, invoices.id')
    .order(revenue: :desc)
    .limit(5)
  end

end
