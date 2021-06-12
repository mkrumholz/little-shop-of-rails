class Admin::InvoicesController < ApplicationController
  include ActionView::Helpers::NumberHelper

  def index
    @invoices = Invoice.all.order(:id)
  end

  def show
    @invoice = Invoice.find(params[:id])
    @customer = Customer.find(@invoice.customer_id)
    @items = @invoice.item_sale_price

    flash[:confirm] = 'Invoice Successfully Updated' if params[:update]
  end

  def update
    @invoice = Invoice.find(params[:id])

    if @invoice.update(status: params[:invoice][:status].to_i)
      redirect_to admin_invoice_path(@invoice.id, update: true)
    end
  end
end
