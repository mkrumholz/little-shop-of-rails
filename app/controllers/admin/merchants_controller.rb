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
    merchant.update(name: params["merchant"]["name"])

    redirect_to "/admin/merchants/#{merchant.id}?update=true"
  end

  def update_status
    merchant = Merchant.find(params[:id])
    merchant.update(status: !merchant.status)

    redirect_to "/admin/merchants"
  end

end
