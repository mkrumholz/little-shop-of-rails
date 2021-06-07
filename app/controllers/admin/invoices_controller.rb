class Admin::InvoicesController < ApplicationController
  include ActionView::Helpers::NumberHelper

  def index
    @invoices = Invoice.all.order(:id)
  end

  def show
    @enum_convert = Invoice.statuses
    @invoice = Invoice.find(params[:id])
    @customer = Customer.find(@invoice.customer_id)
    @items = @invoice.item_sale_price

    if params[:update]
      flash[:confirm] = "Invoice Successfully Updated"
    end
  end

  def update
    @invoice = Invoice.find(params[:id])

    if @invoice.update(status: params[:invoice][:status].to_i)
      redirect_to admin_invoice_path(@invoice.id, update: true)
    # else
    #   redirect_to admin_invoice_path(@invoice.id)
    #   flash[:alert] = "Error: #{error_message(@invoice.errors)}"
    end
  end
end
