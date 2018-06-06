class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_merchant
    @current_merchant ||= Merchant.find(session[:merchant_id]) if session[:merchant_id]
  end

  helper_method :current_merchant

  def authorize
    redirect_to '/merchant/signup' unless current_merchant
  end
end
