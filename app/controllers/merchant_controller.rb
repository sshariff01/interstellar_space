class MerchantController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    redirect_to merchant_path(current_merchant) and return if current_merchant.present?
  end

  def new
    redirect_to merchant_path(current_merchant) and return if current_merchant.present?

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
    params.require(:merchant).permit(:name, :email, :password, :password_confirmation)
  end

end
