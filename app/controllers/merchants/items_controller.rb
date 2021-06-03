class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = Item.where(merchant_id: @merchant.id)
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update 
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    if @item.update!(item_params)
      redirect_to merchant_item_path(@merchant.id, @item.id)
    else
      redirect_to edit_merchant_item_path(@merchant.id, @item.id)
      flash[:alert] = error_message(item.errors)
    end 
  end

  private
    def item_params
      params[:item].permit(:name, :description, :unit_price)
    end
end