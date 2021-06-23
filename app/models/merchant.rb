class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :discounts, dependent: :destroy

  after_initialize :init

  validates :name, uniqueness: true, presence: true
  validates_presence_of :password, require: true, if: :password_required?

  has_secure_password

  def init
    self.status = false if status.nil?
  end

  def render_status
    if status
      { status: 'Enabled', action: 'Disable' }
    else
      { status: 'Disabled', action: 'Enable' }
    end
  end

  def toggle_status
    update(status: !status)
  end

  def top_selling_date
    output = items.select('invoices.created_at AS top_sale_date,
                 SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue')
                  .joins(invoice_items: { invoice: :transactions })
                  .where(transactions: { result: 1 })
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
      .joins(items: { invoice_items: { invoice: :transactions } })
      .where(transactions: { result: 1 })
      .group('merchants.id')
      .order(revenue: :desc)
      .limit(5)
  end

  def enforce_password_validation
    @enforce_password_validation = true
  end

  private
  def password_required?
    @enforce_password_validation || password.present?
  end
end
