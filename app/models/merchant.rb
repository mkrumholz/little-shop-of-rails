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
    output = items.select('invoices.created_at AS top_sale_date,
                 SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue')
         .joins(invoice_items: {invoice: :transactions})
         .where(transactions: {result: 1})
         .group('invoices.created_at')
         .order('revenue DESC, invoices.created_at DESC')
         .limit(1)

   output.first.top_sale_date
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
            sum(invoice_items.unit_price * invoice_items.quantity) AS revenue')
    .joins(items: {invoice_items: {invoice: :transactions}})
    .where(transactions: {result: 1})
    .group('merchants.id')
    .order(revenue: :desc)
    .limit(5)

    #SQL
    # find_by_sql("SELECT merchants.status,
    #                     merchants.id as id,
    #                     merchants.name as name,
    #                     invoices.id as invoice_id,
    #                     sum(invoice_items.unit_price * invoice_items.quantity) AS revenue
    #             FROM
    #             	merchants
    #             	join items on items.merchant_id = merchants.id
    #             	join invoice_items on invoice_items.item_id = items.id
    #             	join invoices on invoice_items.invoice_id = invoices.id
    #             	join transactions on transactions.invoice_id = invoices.id
    #             WHERE
    #             	transactions.result = 1
    #             GROUP BY
    #             	merchants.id
    #             ORDER BY
    #             	revenue DESC
    #             LIMIT 5
    #             ")
  end

end
