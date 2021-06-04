class DashboardController < ApplicationController
  def show
    @merchant = Merchant.find(params[:merchant_id])

    @top_customers = Customer.top_5_customers
  end
end
