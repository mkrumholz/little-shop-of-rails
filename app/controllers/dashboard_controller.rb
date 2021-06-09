class DashboardController < ApplicationController
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @top_customers = Customer.top_5_customers
    @items_to_ship = @merchant.items.ready_to_ship
  end
end
