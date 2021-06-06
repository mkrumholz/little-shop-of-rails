class Admin::InvoicesController < ApplicationController
  include ActionView::Helpers::NumberHelper

  def index
  end

  def show
    @invoice = Invoice.find(params[:id])
    @customer = Customer.find(@invoice.customer_id)
    @items = @invoice.item_sale_price
  end

  def currency_conversion(price_in_cents)
    number_to_currency(price_in_cents)
  end

  helper_method :currency_conversion
end
