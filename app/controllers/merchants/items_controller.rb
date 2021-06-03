class Merchants::ItemsController < ApplicationController
  def index
    merchant = Merchant.find(params[:merchant_id])
    @items = Item.where(merchant_id: merchant.id)
  end
end