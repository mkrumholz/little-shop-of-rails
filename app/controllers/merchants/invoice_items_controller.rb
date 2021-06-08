class Merchants::InvoiceItemsController < ApplicationController
  def update
    merchant = Merchant.find(params[:merchant_id])
    invoice_item = InvoiceItem.find(params[:id])
    invoice_item.update(status: params[:invoice_item][:status].to_i)
    redirect_to merchant_invoice_path(merchant.id, invoice_item.invoice_id)
  end
end