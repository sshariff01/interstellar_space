class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_merchant
    @current_merchant ||= Merchant.find(session[:merchant_id]) if session[:merchant_id]
  end

  helper_method :current_merchant, :site_root_url, :site_domain, :not_found

  def authorize
    redirect_to "#{site_root_url}/merchant/signup" unless current_merchant
  end

  def site_root_url
    "#{request.protocol}#{site_domain}"
  end

  def site_domain
    request.url.match(/^#{request.protocol}(.+\.)*(.+\..+?(?=\/)).+$/).captures.last
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
