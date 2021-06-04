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

    if merchant.update(name: params["merchant"]["name"])
      redirect_to "/admin/merchants/#{merchant.id}?update=true"
    else
      redirect_to "/admin/merchants/#{merchant.id}/edit"
      flash[:alert] = "Error: #{error_message(merchant.errors)}"
    end
  end

  def update_status
    merchant = Merchant.find(params[:id])
    merchant.update(status: !merchant.status)

    redirect_to "/admin/merchants"
  end

end
