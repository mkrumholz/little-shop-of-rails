class Admin::InvoicesController < ApplicationController

  def index
    @invoices = Invoice.all.order(:id)
  end

  def show
    @invoice = Invoice.find(params[:id])
    @customer = Customer.find(@invoice.customer_id)
  end

end
