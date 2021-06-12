class Merchants::DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts.all
  end

  def show
    @discount = Discount.find(params[:id])
  end
end
