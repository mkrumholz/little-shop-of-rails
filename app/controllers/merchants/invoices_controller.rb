class Merchants::InvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_invoices = @merchant.items.merchant_invoices
  end

  def show
    @invoice = Invoice.find(params[:id])
    @customer = Customer.find(@invoice.customer_id)
    # @invoice_items = Invoice.joins(items: :invoice_items)
    # .select("items.name AS item_name, invoice_items.quantity, invoice_items.unit_price, invoice_items.status AS in")
    @invoice_items = InvoiceItem.invoice_items_show(@invoice.id)
  end
end
