class AdminController < ApplicationController

  def index
    @top_customers = Customer.top_five_completed_transactions
    @incomplete_invoices = Invoice.unshipped_items
  end

  def welcome
    @merchants = Merchant.all.limit(10)
  end

end
