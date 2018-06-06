class MerchantController < ApplicationController

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(merchant_params)
    if @merchant.save
      session[:merchant_id] = @merchant.id
      redirect_to '/'
    else
      render 'new'
    end
  end

  private

  def merchant_params
    params.require(:merchant).permit(:email, :password, :password_confirmation)
  end

end
