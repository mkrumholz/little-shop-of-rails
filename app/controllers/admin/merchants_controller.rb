class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])

    flash[:confirm] = 'Merchant Successfully Updated' if params[:update]
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.enforce_password_validation

    if merchant.update(merchant_params)
      redirect_to "/admin/merchants/#{merchant.id}?update=true"
    else
      redirect_to "/admin/merchants/#{merchant.id}/edit"
      flash[:alert] = "Error: #{error_message(merchant.errors)}"
    end
  end

  def update_status
    merchant = Merchant.find(params[:id])
    merchant.toggle_status

    redirect_to '/admin/merchants'
  end

  def new
    @merchant = Merchant.new
  end

  def create
    merchant = Merchant.new(merchant_params)

    if merchant.save
      redirect_to '/admin/merchants'
    else
      redirect_to '/admin/merchants/new'
      flash[:alert] = "Error: #{error_message(merchant.errors)}"
    end
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name, :status, :password)
  end
end
