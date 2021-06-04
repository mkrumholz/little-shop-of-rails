class Admin::InvoicesController < ApplicationController

  def index
    @invoices = Invoice.all.order(:id)
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

end
