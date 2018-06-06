class SessionsController < ApplicationController

  def new
  end

  def create
    merchant = Merchant.find_by_email(params[:email])
    if merchant && merchant.authenticate(params[:password])
      session[:merchant_id] = merchant.id
      redirect_to site_root_path
    else
      @errors = ['Email or password is invalid']
      render 'new'
    end
  end

  def destroy
    session.delete(:merchant_id)
    redirect_to site_root_url
  end

end
