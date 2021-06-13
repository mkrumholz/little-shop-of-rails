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

  def create
    percentage = params[:discount][:percentage].to_f / 100
    discount = @merchant.discounts.new(discount_params.merge(percentage: percentage))
    if discount.save
      redirect_to merchant_discounts_path(@merchant.id)
    else
      redirect_to new_merchant_discount_path(@merchant.id)
      flash[:alert] = "🛑 Error: #{error_message(discount.errors)}"
    end
  end

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  private

  def discount_params
    params[:discount].permit(:name, :quantity_threshold)
  end
end
