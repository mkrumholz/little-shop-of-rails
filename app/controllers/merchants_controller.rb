class MerchantsController < ApplicationController
  def new 
    @merchant = Merchant.new
  end

  def create
    new_merchant = Merchant.create(merchant_params)
    flash[:success] = "Welcome, #{new_merchant.name}!"
    redirect_to '/'
  end

  def login_form
  end

  def login
    merchant = Merchant.find_by(name: params[:name])
    if merchant.authenticate(params[:password])
      session[:merchant_id] = merchant.id
      flash[:success] = "Welcome, #{merchant.name}!"
      redirect_to '/'
    else
      flash[:error] = '🙅🏻‍♀️ Incorrect name or password'
      render :login_form
    end
  end

  private
  def merchant_params
    params.require(:merchant).permit(:name, :status, :password)
  end
end
