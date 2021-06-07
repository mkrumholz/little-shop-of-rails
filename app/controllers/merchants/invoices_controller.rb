class Merchants::InvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_invoices = @merchant.items_of_merchant
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @customer = Customer.find(@invoice.customer_id)
    @invoice_items = InvoiceItem.invoice_items_show(@invoice.id, @merchant.id)
  end
end
