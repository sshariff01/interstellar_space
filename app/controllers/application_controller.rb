class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_merchant
    @current_merchant = Merchant.find_by(pk: session[:merchant_id]) if session[:merchant_id]
  end

  helper_method :current_merchant, :merchant_root_url, :site_domain, :not_found

  def authorize
    redirect_to signup_merchant_url unless current_merchant
  end

  def merchant_root_url
    "#{request.protocol}#{site_domain}"
  end

  def site_domain
    if Rails.env.production?
      request.url.match(/^#{request.protocol}(.+\.)*(.+\..+\..+?(?=\/)).+$/).captures.last
    else
      request.url.match(/^#{request.protocol}(.+\.)*(.+\..+?(?=\/)).+$/).captures.last
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
