class Merchants::DiscountsController < ApplicationController
  before_action :set_merchant
  before_action :set_discount, except: [:index, :new, :create]

  def index
    @discounts = @merchant.discounts.all
  end

  def show; end

  def new
    @discount = Discount.new
    if params[:discount].present?
      percentage = params[:discount][:percentage].to_f / 100
      @discount = Discount.new(discount_params.merge(percentage: percentage))
    end
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

  def edit; end

  def update
    percentage = params[:discount][:percentage].to_f / 100
    if @discount.update(discount_params.merge(percentage: percentage))
      redirect_to merchant_discount_path(@merchant.id, @discount.id)
    else
      redirect_to edit_merchant_discount_path(@merchant.id, @discount.id)
      flash[:alert] = "🛑 Error: #{error_message(@discount.errors)}"
    end
  end

  def destroy
    @discount.destroy
    redirect_to merchant_discounts_path(@merchant.id)
  end

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def set_discount
    @discount = Discount.find(params[:id])
  end

  private

  def discount_params
    params[:discount].permit(:name, :quantity_threshold)
  end
end
