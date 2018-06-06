class ShopController < ApplicationController
  protect_from_forgery prepend: true

  before_action :authorize

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.create(shop_params)

    if @shop.valid?
      shop_urn = "#{request.protocol}#{@shop.urn(request.domain)}"
      shop_urn += ":#{request.port}" if Rails.env.development? || Rails.env.test?
      respond_to do |format|
        format.html { redirect_to shop_urn }
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
    @shop = Shop.find_by_subdomain(request.subdomain)

    if @shop.nil?
      url_for_root = "#{request.protocol}#{request.domain}"
      url_for_root += ":#{request.port}" if Rails.env.development? || Rails.env.test?
      redirect_to url_for_root
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :description, :subdomain)
  end
end
