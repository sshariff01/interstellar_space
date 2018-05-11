class ShopController < ApplicationController
  def new
    @shop = Shop.new
  end

  def create
    shop = Shop.create(shop_params)

    redirect_to generated_shop_url(shop)
  end


  def show
    @shop_name = request.subdomain
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :description, :subdomain)
  end

  def generated_shop_url(shop)
    "#{request.protocol}#{shop.subdomain}.#{request.domain}:#{request.port}"
  end
end
