class MerchantsController < ApplicationController
  def new 
    @merchant = Merchant.new
  end

  def create
    new_merchant = Merchant.create(merchant_params)
    flash[:success] = "Welcome, #{new_merchant.name}!"
    redirect_to '/'
  end

  private
  def merchant_params
    params.require(:merchant).permit(:name, :status, :password)
  end
end
