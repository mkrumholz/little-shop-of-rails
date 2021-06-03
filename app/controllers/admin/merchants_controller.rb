class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])

    if params[:update]
      flash[:confirm] = "Merchant Successfully Updated"
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)

    redirect_to "/admin/merchants/#{merchant.id}?update=true"
  end

  private
  def merchant_params
    params.permit(:name)
  end
end
