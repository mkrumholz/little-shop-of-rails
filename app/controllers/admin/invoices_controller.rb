class Admin::InvoicesController < ApplicationController
  include ActionView::Helpers::NumberHelper

  def index
    @invoices = Invoice.all.order(:id)
  end

  def show
    @invoice = Invoice.find(params[:id])
    @customer = Customer.find(@invoice.customer_id)
    @items = @invoice.item_sale_price
  end

  def update
    @invoice.update(enabled: params[:invoice][:status])

    redirect_to admin_invoice_path(@invoice.id)
  end
end
