class MerchantsController < ApplicationController
  def new 
    @merchant = Merchant.new
  end
end
