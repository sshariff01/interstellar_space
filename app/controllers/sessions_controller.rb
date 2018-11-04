class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    redirect_to site_root_url and return if current_merchant.present?
  end

  def create
    merchant = Merchant.find_by_email(params[:email])
    if merchant && merchant.authenticate(params[:password])
      session[:merchant_id] = merchant.id
      redirect_to merchant_dashboard_path and return
    else
      @errors = ['Email or password is invalid']
      render 'new'
    end
  end

  def destroy
    session.delete(:merchant_id)
    redirect_to site_root_url and return
  end

end
