class DashboardController < ApplicationController
  def show
    @merchant = Merchant.find(params[:merchant_id])

    @customers = Customer.all
  end
end
