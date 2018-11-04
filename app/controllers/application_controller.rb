class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :session_init

  def session_init
    session[:init] = true
  end

  def current_merchant
    @current_merchant = Merchant.find_by(pk: session[:merchant_id]) if session[:merchant_id].present?
  end

  helper_method :current_merchant, :home_url, :site_domain, :not_found

  def authorize
    redirect_to signup_merchant_url unless current_merchant.present?
  end

  def home_url
    "#{request.protocol}#{site_domain}"
  end

  def site_domain
    if Rails.env.production?
      request.url.match(/^#{request.protocol}(.+\.)*(.+\..+\..+?(?=\/)).+$/).captures.last
    else
      if request.host == 'localhost'
        return 'localhost:3000'
      end

      request.url.match(/^#{request.protocol}(.+\.)*(.+\..+?(?=\/)).+$/).captures.last
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
