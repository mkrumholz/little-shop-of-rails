class Merchants::ItemsController < ApplicationController
  include Dollarable

  before_action(:set_merchant)

  def index
    @items = Item.where(merchant_id: @merchant.id)
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update 
    @item = Item.find(params[:id])
    if params[:item][:enabled].present? && @item.update(item_params)
      redirect_to merchant_items_path(@merchant.id)
    else
      if @item.update(item_params.merge(unit_price: price_to_cents(params[:item][:unit_price])))
        redirect_to merchant_item_path(@merchant.id, @item.id)
        flash[:alert] = "Victory! 🥳 This item has been successfully updated."
      else
        redirect_to edit_merchant_item_path(@merchant.id, @item.id)
        flash[:alert] = "Error: #{error_message(@item.errors)}"
      end
    end 
  end

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  private
    def item_params
      params[:item].permit(:name, :description, :enabled)
    end
end