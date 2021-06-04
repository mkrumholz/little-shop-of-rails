class Admin::InvoicesController < ApplicationController

  def index
  end

  def show
    @invoice = Invoice.find(params[:id])
    @customer = Customer.find(@invoice.customer_id)
    @items = @invoice.item_sale_price
  end

end
