class Merchants::InvoicesController < ApplicationController
  before_action :set_merchant

  def index
    @merchant_invoices = @merchant.items_of_merchant
  end

  def show
    @invoice = Invoice.find(params[:id])
    @customer = Customer.find(@invoice.customer_id)
  end

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
