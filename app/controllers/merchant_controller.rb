class MerchantController < ApplicationController

  def index
    render 'show' if current_merchant.present?
  end

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(merchant_params)
    if @merchant.save
      session[:merchant_id] = @merchant.id
      redirect_to merchant_root_path
    else
      render 'new'
    end
  end

  private

  def merchant_params
    params.require(:merchant).permit(:email, :password, :password_confirmation)
  end

end
