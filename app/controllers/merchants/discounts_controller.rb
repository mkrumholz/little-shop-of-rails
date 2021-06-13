class Merchants::DiscountsController < ApplicationController
  before_action :set_merchant

  def index
    @discounts = @merchant.discounts.all
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def new
    @discount = Discount.new
  end

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
