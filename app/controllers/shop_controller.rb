class ShopController < ApplicationController
  def show
    @shop_name = request.subdomain
  end
end
