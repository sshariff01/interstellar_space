class ShopsController < ApplicationController
  protect_from_forgery prepend: true

  before_action :authorize, except: [:show]

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.create(shop_params)

    if @shop.valid?
      shop_urn = "#{request.protocol}#{@shop.urn(site_domain)}"
      session[:merchant_id] = current_merchant.id

      respond_to do |format|
        format.html { redirect_to shop_urn and return }
        format.json {
          render status: :accepted,
                 json: {
                   id: @shop.id,
                   urn: shop_urn
                 },
                 except: [:created_at, :updated_at]
        }
      end
    else
      @errors = @shop.errors.full_messages
      respond_to do |format|
        format.html { render :new }
        format.json {
          render status: :bad_request,
                 json: { errors: @errors }
        }
      end
    end
  end

  def show
    if subdomain.present?
      @shop = Shop.find_by(subdomain: subdomain)

      if @shop.nil?
        redirect_to not_found and return
      end
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :description, :subdomain).merge(merchant_fk: current_merchant.id)
  end

  def subdomain
    @subdomain ||= if Rails.env.production?
      request.url.match(/^#{request.protocol}(.+)\.(.+\..+\..+)\/.*$/).captures.first
    else
      request.url.match(/^#{request.protocol}(.+)\.(.+\..+)\/.*$/).captures.first
    end
  end
end
