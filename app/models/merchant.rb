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

  def self.enabled
    where(status: true)
  end

  def self.disabled
    where(status: false)
  end

  def self.top_5_total_revenue
    find_by_sql("SELECT merchants.status,
                        merchants.id as merch_id,
                        merchants.name as merch_name,
                        invoices.id as invoice_id,
                        sum(invoice_items.unit_price * invoice_items.quantity) AS revenue
                FROM
                	merchants
                	join items on items.merchant_id = merchants.id
                	join invoice_items on invoice_items.item_id = items.id
                	join invoices on invoice_items.invoice_id = invoices.id
                	join transactions on transactions.invoice_id = invoices.id
                WHERE
                	transactions.result = 1
                GROUP BY
                	merchants.id,
                  invoices.id
                ORDER BY
                	revenue DESC
                LIMIT 5
                ")
  end
end
